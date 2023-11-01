Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D37DE3DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjKAO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjKAO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:57:01 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BE010F;
        Wed,  1 Nov 2023 07:56:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so6285206b3a.2;
        Wed, 01 Nov 2023 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698850614; x=1699455414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T5eqcDZB5c0baecYRCFjpMqUqeKyZRbdxM6CaL31wS0=;
        b=hk+P13ew1iUjubBwENVzC94oC7pxfjx/jhWEPu8Dr3AxnfWj6QhWDmtT4gYnWAG5nY
         8NTMp7JLZKyXjzEDZiq8p96io6BL3l9QhLqtVQLvD5XSjK0ErBPKHhI/nPqfDM1xR/ng
         P1BhJEHFJnJFI+g0dyg3l7VH9nRyaW6C/iM1hhd+aNI3CNFXvajR7SyfD8bPDHPiSWBm
         2wgtAtfz9T9Bd4dICo0EyeU/FlNiF7ZPTBgX93pK6z7Te6btcNzLUPBNDPX0f0y77NRs
         7BdsW1yTa1/p7A+icu+yke/gotHNxWnHSZ2IKT3lqPZ0JlkMw5t2exYN4FnTwAljVYH1
         p9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698850614; x=1699455414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5eqcDZB5c0baecYRCFjpMqUqeKyZRbdxM6CaL31wS0=;
        b=lqbWj+x83qRGnwdirsIA3dXtgdmkXRzap+sj3CN4xiueh7MtCqFpAQQv0wRe4cV0CS
         +PYHp44X9+oWxH3XSPuN21HoT5HXL0dC4rO/4kB1ZOMePu0MvtBeWhZzQRdntBLzi/GO
         n8T8wUQe3vDRI+BkVwvNhyFojh4DiRJGYfi3zqGO9bgOQCHL+/PKQUauYDRRt5xQCrOe
         vbLTDK8pOoWi45DH1IWUdd23Aj4mjDA2u/+yJlsdoI+1phdX5rBwTzcFcFCdp98deLU9
         93V37eaVTUO+f2tvIsnDiNUVCro0h1Q22mElOlDmYPEpqN3KqYUGQUWukg2qqY2vNqG9
         otGA==
X-Gm-Message-State: AOJu0YxpcuR+fO3n2QAHjnHA/P7Hq0shrlSUowRCI1nTOQuP8oZ856gI
        dvpi9KVVKWL2L9oWxR2g8Zk=
X-Google-Smtp-Source: AGHT+IGIerrmfy5iTMcHXFqJ9jhYtYTASfoyiH2x+1SaLDtHH00p49QkZs0KZgAx5AbjEtRIn7IgkA==
X-Received: by 2002:a05:6a00:2341:b0:692:b6e8:ce88 with SMTP id j1-20020a056a00234100b00692b6e8ce88mr14510936pfj.17.1698850614271;
        Wed, 01 Nov 2023 07:56:54 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l16-20020a056a0016d000b006bd67a7a7b3sm1384368pfc.68.2023.11.01.07.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 07:56:53 -0700 (PDT)
Message-ID: <0e003343-3c64-4fee-a56f-987a4ef6e336@gmail.com>
Date:   Wed, 1 Nov 2023 23:56:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: translations: add translations links when they
 exist
To:     vegard.nossum@oracle.com
Cc:     akiyks@gmail.com, alexs@kernel.org, carlos.bilbao@amd.com,
        corbet@lwn.net, federico.vaga@vaga.pv.it,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        siyanteng@loongson.cn, src.res.211@gmail.com
References: <20231028162931.261843-1-vegard.nossum@oracle.com>
Content-Language: en-US
In-Reply-To: <20231028162931.261843-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Oct 2023 18:29:31 +0200, Vegard Nossum wrote:
> Add a new Sphinx extension that knows about the translations of kernel
> documentation and can insert links to the translations at the top of
> the document.
>=20
> It basically works like this:
>=20
> 1. Register a new node type, LanguagesNode.
>=20
> 2. Register a new transform, TranslationsTransform, that inserts a new
>    LanguageNode at the top of every document. The LanguageNode contains=

>    "pending references" to translations of the document. The key here
>    is that these are pending (i.e. unresolved) references that may or
>    may not actually exist.
>=20
> 3. Register a 'doctree-resolved' event that iterates over all the
>    LanguageNode nodes. Any unresolved references are filtered out; the
>    list of resolved references is passed to the 'translations.html'
>    template and rendered as an HTML node (if HTML output is selected).
>=20
> Testing: make htmldocs with v7.3.0.

So, I've started playing with this.

It looks like this introduces hysteresis in successive runs of
"make htmldocs" and "make latexdocs".

Steps to reproduce

  1. Run "make cleandocs"

  2. Run "make htmldocs"

  3. Run "make latexdocs"

This aborts with the message (under Sphinx 7.2.6):

  Extension error (translations):
  Handler <function process_languages at 0x7f122f343420> for event 'doctr=
ee-resolved' threw an exception (exception: 'LaTeXBuilder' object has no =
attribute 'templates')
  make[2]: *** [Documentation/Makefile:128: latexdocs] Error 2
  make[1]: *** [/linux/Makefile:1695: latexdocs] Error 2
  make: *** [Makefile:234: __sub-make] Error 2
  Command exited with non-zero status 2

If I run "make latexdocs" in step 2 and "make htmldocs" in step 3,
both runs complete successfully, but html pages don't have the
expected links to other translations.

All I can do is to report the symptoms.
Vegard, can you look into them?

>=20
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/conf.py                         |  2 +-
>  Documentation/sphinx-static/custom.css        |  8 ++
>  .../sphinx/templates/translations.html        | 12 +++
>  Documentation/sphinx/translations.py          | 96 +++++++++++++++++++=

>  4 files changed, 117 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/sphinx/templates/translations.html
>  create mode 100644 Documentation/sphinx/translations.py
>=20
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index d4fdf6a3875a..64eab500b2cd 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -55,7 +55,7 @@ needs_sphinx =3D '1.7'
>  extensions =3D ['kerneldoc', 'rstFlatTable', 'kernel_include',
>                'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
>                'maintainers_include', 'sphinx.ext.autosectionlabel',
> -              'kernel_abi', 'kernel_feat']
> +              'kernel_abi', 'kernel_feat', 'translations']
> =20
>  if major >=3D 3:
>      if (major > 3) or (minor > 0 or patch >=3D 2):
> diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sph=
inx-static/custom.css
> index 084a884f6fb7..33adee4a35d9 100644
> --- a/Documentation/sphinx-static/custom.css
> +++ b/Documentation/sphinx-static/custom.css
> @@ -73,3 +73,11 @@ input.kernel-toc-toggle { display: none; }
>      h3.kernel-toc-contents { display: inline; }
>      div.kerneltoc a { color: black; }
>  }
> +
> +/* Language selection bar */
> +div.language-selection {
> +    background: #eeeeee;
> +    border: 1px solid #cccccc;
> +    margin-bottom: 1em;
> +    padding: .5em;
> +}
> diff --git a/Documentation/sphinx/templates/translations.html b/Documen=
tation/sphinx/templates/translations.html
> new file mode 100644
> index 000000000000..08afb595c203
> --- /dev/null
> +++ b/Documentation/sphinx/templates/translations.html
> @@ -0,0 +1,12 @@
> +<!-- SPDX-License-Identifier: GPL-2.0 -->
> +<!-- Copyright =C2=A9 2023, Oracle and/or its affiliates. -->
> +
> +{# Create a language bar for translations #}
> +{% if languages|length > 0: %}
> +<div class=3D"language-selection">
> +Languages:
> +{% for ref in languages: %}
> +<a href=3D"{{ ref.refuri }}">{{ ref.astext() }}</a>{% if not loop.last=
 %}, {% endif %}
> +{% endfor %}
> +</div>
> +{% endif %}
> diff --git a/Documentation/sphinx/translations.py b/Documentation/sphin=
x/translations.py
> new file mode 100644
> index 000000000000..e1da811bdaf0
> --- /dev/null
> +++ b/Documentation/sphinx/translations.py
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright =C2=A9 2023, Oracle and/or its affiliates.
> +# Author: Vegard Nossum <vegard.nossum@oracle.com>
> +#
> +# Add translation links to the top of the document.
> +#
> +
> +import os
> +
> +from docutils import nodes
> +from docutils.transforms import Transform
> +
> +import sphinx
> +from sphinx import addnodes
> +from sphinx.errors import NoUri

NoUri is not in sphinx.errors prior to Sphinx 2.
I think it is a good chance to finally get rid of Sphinx 1.7.x
support.

        Thanks, Akira

> +
> +all_languages =3D {
> +    # English is always first
> +    None: 'English',
> +
> +    # Keep the rest sorted alphabetically
> +    'zh_CN': 'Chinese',
> +    'it_IT': 'Italian',
> +    'ja_JP': 'Japanese',
> +    'ko_KR': 'Korean',
> +    'sp_SP': 'Spanish',
> +    'zh_TW': 'Taiwanese',
> +}
> +
> +class LanguagesNode(nodes.Element):
> +    pass
> +
> +class TranslationsTransform(Transform):
> +    default_priority =3D 900
> +
> +    def apply(self):
> +        app =3D self.document.settings.env.app
> +        if app.builder.format not in ['html']:
> +            return
> +
> +        docname =3D self.document.settings.env.docname
> +
> +        this_lang_code =3D None
> +        components =3D docname.split(os.sep)
> +        if components[0] =3D=3D 'translations' and len(components) > 2=
:
> +            this_lang_code =3D components[1]
> +
> +            # normalize docname to be the untranslated one
> +            docname =3D os.path.join(*components[2:])
> +
> +        new_nodes =3D LanguagesNode()
> +
> +        for lang_code, lang_name in all_languages.items():
> +            if lang_code =3D=3D this_lang_code:
> +                continue
> +
> +            if lang_code is None:
> +                target_name =3D docname
> +            else:
> +                target_name =3D os.path.join('translations', lang_code=
, docname)
> +
> +            pxref =3D addnodes.pending_xref('', refdomain=3D'std',
> +                reftype=3D'doc', reftarget=3D'/' + target_name, modnam=
e=3DNone,
> +                classname=3DNone, refexplicit=3DTrue)
> +            pxref +=3D nodes.Text(lang_name)
> +            new_nodes +=3D pxref
> +
> +        self.document.insert(0, new_nodes)
> +
> +def process_languages(app, doctree, docname):
> +    for node in doctree.traverse(LanguagesNode):
> +        languages =3D []
> +
> +        # Iterate over the child nodes; any resolved links will have
> +        # the type 'nodes.reference', while unresolved links will be
> +        # type 'nodes.Text'.
> +        languages =3D list(filter(lambda xref:
> +            isinstance(xref, nodes.reference), node.children))
> +
> +        html_content =3D app.builder.templates.render('translations.ht=
ml',
> +            context=3D{
> +                'languages': languages,
> +            })
> +
> +        node.replace_self(nodes.raw('', html_content, format=3D'html')=
)
> +
> +def setup(app):
> +    app.add_node(LanguagesNode)
> +    app.add_transform(TranslationsTransform)
> +    app.connect('doctree-resolved', process_languages)
> +
> +    return {
> +        'parallel_read_safe': True,
> +        'parallel_write_safe': True,
> +    }
> --=20
> 2.34.1

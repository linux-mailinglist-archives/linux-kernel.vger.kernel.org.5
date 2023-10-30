Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7147DBE86
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjJ3RLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjJ3RL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:11:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4539710B;
        Mon, 30 Oct 2023 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698685884; x=1730221884;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=5SHS0YMOkn5JVvPfG41/C9UnVXfwBzYy9NEvR6uPjJI=;
  b=CtJJN5iSuX1nlB7sW1nW127O/3bHBXqdwQiRYV9hUltnXMlIXnc0KCGt
   9k+q77PNRIPgDJakiusSv+huXrYm5Npi1qyfpWSbJZxC1Z/gdLtB01IQG
   5G1ahwArkVGrg/P68LnttDulHlt/GAzScNZiQoEhT4i65c26Hyc+gs/fB
   Vd/btznajI9ATJUw+Ovv96spIOqRslP5VFqVug65z60af38AN0mwkvfo1
   MVvqQh+Ic7uRkqCMoc+Gagh6WQ6QgYUxgewCJMPdW69HwbrBE2csL9+im
   52HwOKY1xXQAQq2C1izyGXw4PgwtB29kbIxlxjzzNFz3NJQEd26zd4a7L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="385311687"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="385311687"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 10:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877207770"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="877207770"
Received: from squtub-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.238])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 10:11:19 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Akira Yokosawa <akiyks@gmail.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res.211@gmail.com>,
        linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH] docs: translations: add translations links when they exist
In-Reply-To: <20231028162931.261843-1-vegard.nossum@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231028162931.261843-1-vegard.nossum@oracle.com>
Date:   Mon, 30 Oct 2023 19:11:07 +0200
Message-ID: <878r7k593o.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2023, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> Add a new Sphinx extension that knows about the translations of kernel
> documentation and can insert links to the translations at the top of
> the document.
>
> It basically works like this:
>
> 1. Register a new node type, LanguagesNode.
>
> 2. Register a new transform, TranslationsTransform, that inserts a new
>    LanguageNode at the top of every document. The LanguageNode contains
>    "pending references" to translations of the document. The key here
>    is that these are pending (i.e. unresolved) references that may or
>    may not actually exist.
>
> 3. Register a 'doctree-resolved' event that iterates over all the
>    LanguageNode nodes. Any unresolved references are filtered out; the
>    list of resolved references is passed to the 'translations.html'
>    template and rendered as an HTML node (if HTML output is selected).
>
> Testing: make htmldocs with v7.3.0.

I'm just observing the kernel documentation has a system of its own for
translations. Maybe it's fine this way, but it's certainly different
from what the Sphinx developers had in mind. (But I'm not an expert on
this field, don't ask me how this should be done!)

Regardless, the implication is that this builds on the translation
solution chosen for kernel documentation, for better and for worse, and
raises the bar for switching later. It's something to be aware of.

>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/conf.py                         |  2 +-
>  Documentation/sphinx-static/custom.css        |  8 ++
>  .../sphinx/templates/translations.html        | 12 +++
>  Documentation/sphinx/translations.py          | 96 +++++++++++++++++++
>  4 files changed, 117 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/sphinx/templates/translations.html
>  create mode 100644 Documentation/sphinx/translations.py
>
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
>=20=20
>  if major >=3D 3:
>      if (major > 3) or (minor > 0 or patch >=3D 2):
> diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphin=
x-static/custom.css
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
> diff --git a/Documentation/sphinx/templates/translations.html b/Documenta=
tion/sphinx/templates/translations.html
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
> +<a href=3D"{{ ref.refuri }}">{{ ref.astext() }}</a>{% if not loop.last %=
}, {% endif %}
> +{% endfor %}
> +</div>
> +{% endif %}

This could also be part of the menu on the left, I think it's fairly
easy to extend in alabaster. But then again it's already pretty crowded,
and it's all a matter of taste.

> diff --git a/Documentation/sphinx/translations.py b/Documentation/sphinx/=
translations.py
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

Maybe the path to translations should be a configuration option for the
extension, and it could read the translations from the directory instead
of hard coding them here.

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
> +        if components[0] =3D=3D 'translations' and len(components) > 2:
> +            this_lang_code =3D components[1]
> +
> +            # normalize docname to be the untranslated one
> +            docname =3D os.path.join(*components[2:])

Need to rename these files, and keep the translated document names
up-to-date:

for f in $(find Documentation/translations/ -name "*.rst"); do if ! test -f=
 Documentation/${f##Documentation/translations/??_??/}; then echo $f; fi; d=
one

Maybe the extension should warn about documents under translations that
do not have a corresponding original.

BR,
Jani.

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
> +                target_name =3D os.path.join('translations', lang_code, =
docname)
> +
> +            pxref =3D addnodes.pending_xref('', refdomain=3D'std',
> +                reftype=3D'doc', reftarget=3D'/' + target_name, modname=
=3DNone,
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
> +        html_content =3D app.builder.templates.render('translations.html=
',
> +            context=3D{
> +                'languages': languages,
> +            })
> +
> +        node.replace_self(nodes.raw('', html_content, format=3D'html'))
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

--=20
Jani Nikula, Intel

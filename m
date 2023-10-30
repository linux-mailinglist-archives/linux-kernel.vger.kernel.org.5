Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7819A7DB91C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjJ3LjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3LjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:39:11 -0400
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 04:39:06 PDT
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B6B6;
        Mon, 30 Oct 2023 04:39:06 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 2383A300D3C0;
        Mon, 30 Oct 2023 12:31:05 +0100 (CET)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received:received;
         s=dkim20160331; t=1698665461; x=1700479862; bh=eBDtrN7ZvBxFwKuZ
        vgReLOW8gdMuBQzsiliNBUr48oo=; b=2Ar7ReonuU2AMblzpP+eFajn0xGEo4Hp
        cNiwDc40KGvOkQzi6mLGDqAHTPjRequ5VjtA2eOHxz4AIlwEv+edQ8iI3rS4Qsat
        7RqNAfmnHnsmuLiuCgq0FD8UJ8WvEayHCztpFaQjZNf92GCIDBYY8/VAOIBIF4tR
        qGtkBJYgm+PK4hHvVLN+6NmgnON3+CnexmpEA3T9htGji1qOaQPPjzGyqY6tWi/f
        cWQrsRX+WZvkVOByYurHQzVky9UvPK8hJUpbJ5mlhiqe1hPuBIuRnyU8H7N2M/wp
        ovX3UBlBFGlOrmQlbf8DyZIeWC7jtkpnn/aNeASdcfWHwCdGTqQXWvybwZAFislA
        lQT5Yxcm7fhwdptsfGYJ6LZ683NLIWOeyoVmrt6qHNBDLpfW8w1Zsv69eath7CaO
        zVJLQmnhBoJTxMiee3XMtanUooktxZShsxTEMju4LlHGIwlPcMSTVcOWzmkusVcb
        fygmUX0u51PnBrFcFEaSr3KBT8nwCgr467dXeIY8BuUpa5YbDVvQ9mV7tKrCne5p
        lClgqRfbMgPz04QoM2ZWulE9yi7LfPasSWklypWsZeqI/7ipr7gPNozARrDvM1d3
        YpcfUhkRabHjYFU1LYnSFXS+dJ6txHhFn3MXEtRgj6tViGBdvPoVoam9wtABahdB
        PMKgTINdICU=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id zVXVNBbUoT_A; Mon, 30 Oct 2023 12:31:01 +0100 (CET)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
        by mx.kolabnow.com (Postfix) with ESMTPS id 0712F300D37F;
        Mon, 30 Oct 2023 12:30:54 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
        by int-mx009.mykolab.com (Postfix) with ESMTPS id 565E820DFFCB;
        Mon, 30 Oct 2023 12:30:54 +0100 (CET)
Date:   Mon, 30 Oct 2023 12:30:52 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res.211@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: translations: add translations links when they
 exist
Message-ID: <20231030113052.ykblzg2jdca6pmlt@numero-86.vaga.pv.it>
References: <20231028162931.261843-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231028162931.261843-1-vegard.nossum@oracle.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find it a nice initiative :)

On Sat, Oct 28, 2023 at 06:29:31PM +0200, Vegard Nossum wrote:
>Add a new Sphinx extension that knows about the translations of kernel
>documentation and can insert links to the translations at the top of
>the document.
>
>It basically works like this:
>
>1. Register a new node type, LanguagesNode.
>
>2. Register a new transform, TranslationsTransform, that inserts a new
>   LanguageNode at the top of every document. The LanguageNode contains
>   "pending references" to translations of the document. The key here
>   is that these are pending (i.e. unresolved) references that may or
>   may not actually exist.
>
>3. Register a 'doctree-resolved' event that iterates over all the
>   LanguageNode nodes. Any unresolved references are filtered out; the
>   list of resolved references is passed to the 'translations.html'
>   template and rendered as an HTML node (if HTML output is selected).
>
>Testing: make htmldocs with v7.3.0.
>
>Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>---
> Documentation/conf.py                         |  2 +-
> Documentation/sphinx-static/custom.css        |  8 ++
> .../sphinx/templates/translations.html        | 12 +++
> Documentation/sphinx/translations.py          | 96 +++++++++++++++++++
> 4 files changed, 117 insertions(+), 1 deletion(-)
> create mode 100644 Documentation/sphinx/templates/translations.html
> create mode 100644 Documentation/sphinx/translations.py
>
>diff --git a/Documentation/conf.py b/Documentation/conf.py
>index d4fdf6a3875a..64eab500b2cd 100644
>--- a/Documentation/conf.py
>+++ b/Documentation/conf.py
>@@ -55,7 +55,7 @@ needs_sphinx = '1.7'
> extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
>               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
>               'maintainers_include', 'sphinx.ext.autosectionlabel',
>-              'kernel_abi', 'kernel_feat']
>+              'kernel_abi', 'kernel_feat', 'translations']
>
> if major >= 3:
>     if (major > 3) or (minor > 0 or patch >= 2):
>diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
>index 084a884f6fb7..33adee4a35d9 100644
>--- a/Documentation/sphinx-static/custom.css
>+++ b/Documentation/sphinx-static/custom.css
>@@ -73,3 +73,11 @@ input.kernel-toc-toggle { display: none; }
>     h3.kernel-toc-contents { display: inline; }
>     div.kerneltoc a { color: black; }
> }
>+
>+/* Language selection bar */
>+div.language-selection {
>+    background: #eeeeee;
>+    border: 1px solid #cccccc;
>+    margin-bottom: 1em;
>+    padding: .5em;
>+}
>diff --git a/Documentation/sphinx/templates/translations.html b/Documentation/sphinx/templates/translations.html
>new file mode 100644
>index 000000000000..08afb595c203
>--- /dev/null
>+++ b/Documentation/sphinx/templates/translations.html
>@@ -0,0 +1,12 @@
>+<!-- SPDX-License-Identifier: GPL-2.0 -->
>+<!-- Copyright © 2023, Oracle and/or its affiliates. -->
>+
>+{# Create a language bar for translations #}
>+{% if languages|length > 0: %}
>+<div class="language-selection">
>+Languages:

Should also "Languages" subject to translation?
Or perhaps, nothing. Just the list of languages.

>+{% for ref in languages: %}
>+<a href="{{ ref.refuri }}">{{ ref.astext() }}</a>{% if not loop.last %}, {% endif %}
>+{% endfor %}
>+</div>
>+{% endif %}
>diff --git a/Documentation/sphinx/translations.py b/Documentation/sphinx/translations.py
>new file mode 100644
>index 000000000000..e1da811bdaf0
>--- /dev/null
>+++ b/Documentation/sphinx/translations.py
>@@ -0,0 +1,96 @@
>+# SPDX-License-Identifier: GPL-2.0
>+#
>+# Copyright © 2023, Oracle and/or its affiliates.
>+# Author: Vegard Nossum <vegard.nossum@oracle.com>
>+#
>+# Add translation links to the top of the document.
>+#
>+
>+import os
>+
>+from docutils import nodes
>+from docutils.transforms import Transform
>+
>+import sphinx
>+from sphinx import addnodes
>+from sphinx.errors import NoUri
>+
>+all_languages = {
>+    # English is always first
>+    None: 'English',
>+
>+    # Keep the rest sorted alphabetically
>+    'zh_CN': 'Chinese',
>+    'it_IT': 'Italian',
>+    'ja_JP': 'Japanese',
>+    'ko_KR': 'Korean',
>+    'sp_SP': 'Spanish',
>+    'zh_TW': 'Taiwanese',

Minor comment. Should we use the language name in its original language?

Example:

[... snip ...]
'it_IT': Italiano,
[... snip ...]
'sp_SP': Español,
[... snip ...]

>+}
>+
>+class LanguagesNode(nodes.Element):
>+    pass
>+
>+class TranslationsTransform(Transform):
>+    default_priority = 900
>+
>+    def apply(self):
>+        app = self.document.settings.env.app
>+        if app.builder.format not in ['html']:
>+            return
>+
>+        docname = self.document.settings.env.docname
>+
>+        this_lang_code = None
>+        components = docname.split(os.sep)
>+        if components[0] == 'translations' and len(components) > 2:
>+            this_lang_code = components[1]
>+
>+            # normalize docname to be the untranslated one
>+            docname = os.path.join(*components[2:])
>+
>+        new_nodes = LanguagesNode()
>+
>+        for lang_code, lang_name in all_languages.items():
>+            if lang_code == this_lang_code:
>+                continue

We could show all languages (remove the above two lines) to have a consistent
output among pages.

>+            if lang_code is None:
>+                target_name = docname
>+            else:
>+                target_name = os.path.join('translations', lang_code, docname)
>+
>+            pxref = addnodes.pending_xref('', refdomain='std',
>+                reftype='doc', reftarget='/' + target_name, modname=None,
>+                classname=None, refexplicit=True)
>+            pxref += nodes.Text(lang_name)
>+            new_nodes += pxref
>+
>+        self.document.insert(0, new_nodes)
>+
>+def process_languages(app, doctree, docname):
>+    for node in doctree.traverse(LanguagesNode):
>+        languages = []
>+
>+        # Iterate over the child nodes; any resolved links will have
>+        # the type 'nodes.reference', while unresolved links will be
>+        # type 'nodes.Text'.
>+        languages = list(filter(lambda xref:
>+            isinstance(xref, nodes.reference), node.children))
>+
>+        html_content = app.builder.templates.render('translations.html',
>+            context={
>+                'languages': languages,
>+            })
>+
>+        node.replace_self(nodes.raw('', html_content, format='html'))
>+
>+def setup(app):
>+    app.add_node(LanguagesNode)
>+    app.add_transform(TranslationsTransform)
>+    app.connect('doctree-resolved', process_languages)
>+
>+    return {
>+        'parallel_read_safe': True,
>+        'parallel_write_safe': True,
>+    }
>-- 
>2.34.1
>

-- 
Federico Vaga

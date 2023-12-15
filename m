Return-Path: <linux-kernel+bounces-932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF98814832
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4DF281892
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5072C852;
	Fri, 15 Dec 2023 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ONBEPTFh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A762C69A;
	Fri, 15 Dec 2023 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFATMxX023232;
	Fri, 15 Dec 2023 12:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=ZUZTXTDUolFqRDCQTLnhgCYqyD/e3Xcfc9NMlG6mxV0=;
 b=ONBEPTFhajW5+Ws3e2oY2vz6fjlQ5JsUwC5tSdlrnCjuLWtwO/lyspgK50sjw/rhhhk4
 ZtOk0jOvVBrK6CJffeHd5WapITjBPA14FCX51mlZcOKgckt4rCdTYJMYCG0GKQB4Rgmf
 ylwXaPsW35/63KL6jgTXn84mbw8780+o1WcjRFQ8XSFPpbSgYPhbNbTb5RFi+bV1X/kA
 JY+xIAQjuyb79+j807usoFwNOcdw05uaosfp3EEtWGBRrNkZn5FxpZx6koTcliVfklxU
 +6FwBTy5EXWGHhb4HgBNnMVtNRB+lB3lfBjoYBJpghACI2M1rUhqnIpQfW8NMY4QGPZr +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu2d6ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 12:37:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFCL9jk003225;
	Fri, 15 Dec 2023 12:37:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepbrgvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 12:37:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFCbBrH022727;
	Fri, 15 Dec 2023 12:37:11 GMT
Received: from localhost.localdomain (dhcp-10-175-50-46.vpn.oracle.com [10.175.50.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvepbrgt9-1;
	Fri, 15 Dec 2023 12:37:11 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Carlos Bilbao <carlos.bilbao@amd.com>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res.211@gmail.com>,
        linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Akira Yokosawa <akiyks@gmail.com>, Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH v2] docs: translations: add translations links when they exist
Date: Fri, 15 Dec 2023 13:37:01 +0100
Message-Id: <20231215123701.2712807-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_07,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150084
X-Proofpoint-ORIG-GUID: kDSfvGz57jB4CSFShbkD8bvHQo1gH0f4
X-Proofpoint-GUID: kDSfvGz57jB4CSFShbkD8bvHQo1gH0f4

Add a new Sphinx extension that knows about the translations of kernel
documentation and can insert links to the translations at the top of
the document.

It basically works like this:

1. Register a new node type, LanguagesNode.

2. Register a new transform, TranslationsTransform, that inserts a new
   LanguageNode at the top of every document. The LanguageNode contains
   "pending references" to translations of the document. The key here
   is that these are pending (i.e. unresolved) references that may or
   may not actually exist.

3. Register a 'doctree-resolved' event that iterates over all the
   LanguageNode nodes. Any unresolved references are filtered out; the
   list of resolved references is passed to the 'translations.html'
   template and rendered as an HTML node (if HTML output is selected).

Testing: make htmldocs, make latexdocs with Sphinx v4.3.2 and Firefox.

v2:
- changed bar into a drop-down menu
- fixed language labels
- fixed hysteresis reported by Akira Yokosawa

Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/conf.py                         |   2 +-
 Documentation/sphinx-static/custom.css        |  53 +++++++++
 .../sphinx/templates/translations.html        |  15 +++
 Documentation/sphinx/translations.py          | 101 ++++++++++++++++++
 4 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/sphinx/templates/translations.html
 create mode 100644 Documentation/sphinx/translations.py

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 20bd74edcca9..2edd4891b384 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -55,7 +55,7 @@ needs_sphinx = '1.7'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat']
+              'kernel_abi', 'kernel_feat', 'translations']
 
 if major >= 3:
     if (major > 3) or (minor > 0 or patch >= 2):
diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
index c992b1946edc..aa66de615253 100644
--- a/Documentation/sphinx-static/custom.css
+++ b/Documentation/sphinx-static/custom.css
@@ -82,3 +82,56 @@ input.kernel-toc-toggle { display: none; }
     h3.kernel-toc-contents { display: inline; }
     div.kerneltoc a { color: black; }
 }
+
+/* Language selection menu */
+
+div.admonition {
+    /*
+     * Make sure we don't overlap notes and warnings at the top of the
+     * document.
+     */
+    clear: both;
+}
+
+div.language-selection {
+    background: #eeeeee;
+    border: 1px solid #cccccc;
+    margin-bottom: 1em;
+    padding: .5em;
+
+    position: relative;
+    float: right;
+}
+
+div.language-selection a {
+    display: block;
+    padding: 0.5em;
+    color: #333333;
+    text-decoration: none;
+}
+
+div.language-selection ul {
+    display: none;
+    position: absolute;
+
+    /* Align with the parent div */
+    top: 100%;
+    right: 0;
+    margin: 0;
+
+    list-style: none;
+
+    background: #fafafa;
+    border: 1px solid #cccccc;
+
+    /* Never break menu item lines */
+    white-space: nowrap;
+}
+
+div.language-selection:hover ul {
+    display: block;
+}
+
+div.language-selection ul li:hover {
+    background: #dddddd;
+}
diff --git a/Documentation/sphinx/templates/translations.html b/Documentation/sphinx/templates/translations.html
new file mode 100644
index 000000000000..8df5d42d8dcd
--- /dev/null
+++ b/Documentation/sphinx/templates/translations.html
@@ -0,0 +1,15 @@
+<!-- SPDX-License-Identifier: GPL-2.0 -->
+<!-- Copyright © 2023, Oracle and/or its affiliates. -->
+
+{# Create a language menu for translations #}
+{% if languages|length > 0: %}
+<div class="language-selection">
+{{ current_language }}
+
+<ul>
+{% for ref in languages: %}
+<li><a href="{{ ref.refuri }}">{{ ref.astext() }}</a></li>
+{% endfor %}
+</ul>
+</div>
+{% endif %}
diff --git a/Documentation/sphinx/translations.py b/Documentation/sphinx/translations.py
new file mode 100644
index 000000000000..47161e6eba99
--- /dev/null
+++ b/Documentation/sphinx/translations.py
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright © 2023, Oracle and/or its affiliates.
+# Author: Vegard Nossum <vegard.nossum@oracle.com>
+#
+# Add translation links to the top of the document.
+#
+
+import os
+
+from docutils import nodes
+from docutils.transforms import Transform
+
+import sphinx
+from sphinx import addnodes
+from sphinx.errors import NoUri
+
+all_languages = {
+    # English is always first
+    None: 'English',
+
+    # Keep the rest sorted alphabetically
+    'zh_CN': 'Chinese (Simplified)',
+    'zh_TW': 'Chinese (Traditional)',
+    'it_IT': 'Italian',
+    'ja_JP': 'Japanese',
+    'ko_KR': 'Korean',
+    'sp_SP': 'Spanish',
+}
+
+class LanguagesNode(nodes.Element):
+    def __init__(self, current_language, *args, **kwargs):
+        super().__init__(*args, **kwargs)
+
+        self.current_language = current_language
+
+class TranslationsTransform(Transform):
+    default_priority = 900
+
+    def apply(self):
+        app = self.document.settings.env.app
+        docname = self.document.settings.env.docname
+
+        this_lang_code = None
+        components = docname.split(os.sep)
+        if components[0] == 'translations' and len(components) > 2:
+            this_lang_code = components[1]
+
+            # normalize docname to be the untranslated one
+            docname = os.path.join(*components[2:])
+
+        new_nodes = LanguagesNode(all_languages[this_lang_code])
+
+        for lang_code, lang_name in all_languages.items():
+            if lang_code == this_lang_code:
+                continue
+
+            if lang_code is None:
+                target_name = docname
+            else:
+                target_name = os.path.join('translations', lang_code, docname)
+
+            pxref = addnodes.pending_xref('', refdomain='std',
+                reftype='doc', reftarget='/' + target_name, modname=None,
+                classname=None, refexplicit=True)
+            pxref += nodes.Text(lang_name)
+            new_nodes += pxref
+
+        self.document.insert(0, new_nodes)
+
+def process_languages(app, doctree, docname):
+    for node in doctree.traverse(LanguagesNode):
+        if app.builder.format not in ['html']:
+            node.parent.remove(node)
+            continue
+
+        languages = []
+
+        # Iterate over the child nodes; any resolved links will have
+        # the type 'nodes.reference', while unresolved links will be
+        # type 'nodes.Text'.
+        languages = list(filter(lambda xref:
+            isinstance(xref, nodes.reference), node.children))
+
+        html_content = app.builder.templates.render('translations.html',
+            context={
+                'current_language': node.current_language,
+                'languages': languages,
+            })
+
+        node.replace_self(nodes.raw('', html_content, format='html'))
+
+def setup(app):
+    app.add_node(LanguagesNode)
+    app.add_transform(TranslationsTransform)
+    app.connect('doctree-resolved', process_languages)
+
+    return {
+        'parallel_read_safe': True,
+        'parallel_write_safe': True,
+    }
-- 
2.34.1



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD007DA811
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjJ1QaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjJ1QaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:30:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F1EB;
        Sat, 28 Oct 2023 09:30:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39S5GTDH027570;
        Sat, 28 Oct 2023 16:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=b32Ho9TlxRqA+lGs0AbT5dgfNMW2JGlPfC8cer5+j5o=;
 b=tC7EwQC1r5Up9d3wZkfhsBAdj/eOXHGQOEjbg8GWZyWowKU6LndhJ3Ha3zIEa098BbAP
 NkqFBKepTmAnCF5sSAw94xX7PoksKL5rYT4Kl70M0HQmi9JUZZztHaDCcE+4KGTVelg9
 ZqlT8btXrSMb/dalrrG5wYIrEPrj+A8mOcXVVCDbLCN6v07gZvo58JIFDD0cEQhXUHxA
 vkO/8XlRgVhsPEo/a0w8DzCwaO+iWI/OWODscK4hMUtsPAOB+UUzJ4VpPeHCTlJv40Rq
 oJ1UvnVa/Y//9TPpC7ghcB2dk17oIUZEXi70f7CqJ09o3BIqN+R5CyEAbNsmf6z49irt Xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqdrmnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Oct 2023 16:29:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39SBCVIV030752;
        Sat, 28 Oct 2023 16:29:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr8y2h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Oct 2023 16:29:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39SGTdgL026344;
        Sat, 28 Oct 2023 16:29:39 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-33-123.vpn.oracle.com [10.175.33.123])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u0rr8y2gm-1;
        Sat, 28 Oct 2023 16:29:39 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Akira Yokosawa <akiyks@gmail.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res.211@gmail.com>,
        linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH] docs: translations: add translations links when they exist
Date:   Sat, 28 Oct 2023 18:29:31 +0200
Message-Id: <20231028162931.261843-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-28_15,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310280132
X-Proofpoint-ORIG-GUID: _Ev5Xq1gNTxfDJ48GX9LoBhpgE8hsTf0
X-Proofpoint-GUID: _Ev5Xq1gNTxfDJ48GX9LoBhpgE8hsTf0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Testing: make htmldocs with v7.3.0.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/conf.py                         |  2 +-
 Documentation/sphinx-static/custom.css        |  8 ++
 .../sphinx/templates/translations.html        | 12 +++
 Documentation/sphinx/translations.py          | 96 +++++++++++++++++++
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/sphinx/templates/translations.html
 create mode 100644 Documentation/sphinx/translations.py

diff --git a/Documentation/conf.py b/Documentation/conf.py
index d4fdf6a3875a..64eab500b2cd 100644
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
index 084a884f6fb7..33adee4a35d9 100644
--- a/Documentation/sphinx-static/custom.css
+++ b/Documentation/sphinx-static/custom.css
@@ -73,3 +73,11 @@ input.kernel-toc-toggle { display: none; }
     h3.kernel-toc-contents { display: inline; }
     div.kerneltoc a { color: black; }
 }
+
+/* Language selection bar */
+div.language-selection {
+    background: #eeeeee;
+    border: 1px solid #cccccc;
+    margin-bottom: 1em;
+    padding: .5em;
+}
diff --git a/Documentation/sphinx/templates/translations.html b/Documentation/sphinx/templates/translations.html
new file mode 100644
index 000000000000..08afb595c203
--- /dev/null
+++ b/Documentation/sphinx/templates/translations.html
@@ -0,0 +1,12 @@
+<!-- SPDX-License-Identifier: GPL-2.0 -->
+<!-- Copyright © 2023, Oracle and/or its affiliates. -->
+
+{# Create a language bar for translations #}
+{% if languages|length > 0: %}
+<div class="language-selection">
+Languages:
+{% for ref in languages: %}
+<a href="{{ ref.refuri }}">{{ ref.astext() }}</a>{% if not loop.last %}, {% endif %}
+{% endfor %}
+</div>
+{% endif %}
diff --git a/Documentation/sphinx/translations.py b/Documentation/sphinx/translations.py
new file mode 100644
index 000000000000..e1da811bdaf0
--- /dev/null
+++ b/Documentation/sphinx/translations.py
@@ -0,0 +1,96 @@
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
+    'zh_CN': 'Chinese',
+    'it_IT': 'Italian',
+    'ja_JP': 'Japanese',
+    'ko_KR': 'Korean',
+    'sp_SP': 'Spanish',
+    'zh_TW': 'Taiwanese',
+}
+
+class LanguagesNode(nodes.Element):
+    pass
+
+class TranslationsTransform(Transform):
+    default_priority = 900
+
+    def apply(self):
+        app = self.document.settings.env.app
+        if app.builder.format not in ['html']:
+            return
+
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
+        new_nodes = LanguagesNode()
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


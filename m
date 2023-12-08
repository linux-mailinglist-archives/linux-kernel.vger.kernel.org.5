Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EFA80B078
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 00:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjLHXKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHXKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:10:12 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210DD90;
        Fri,  8 Dec 2023 15:10:18 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BDE1C37F;
        Fri,  8 Dec 2023 23:10:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BDE1C37F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1702077017; bh=h1vmUzNrA1esMkjOn4r8ba6qLg2focxoebfLYZwtvB4=;
        h=From:To:Cc:Subject:Date:From;
        b=MX82t5rwEJ68bqtiGnOJFlwLTLzVjg7hDVYqMCPW9e9CBmeY+Ewes8GA+Fhe4DVco
         qBm6/Bp4dyMQnP8Q5qDwjDBRoRYirnrL1emysv6sEDAOT5tqkq0md6baS1Vwc2ZZvV
         UxJdNX/iAy5ezsbsxWM2JZwZs6aukQsK17GSfKp53f3uy/Od5u2IYLL6upfabuif3t
         OpVt3ZMqhWfvxhBV0CaD4a2LNX5rtbWY1vZQwvbE4swtmUFgsiVPXkbdM5P0KiK8Fj
         0xy3it+qxINOU55bmjn3uZBXSAQqIy/1exqQM6K3NYcmrxJllZr4sYIXxNOlMv3vaq
         TXHRITX9xwFog==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2] docs: Raise the minimum Sphinx requirement to 2.4.4
Date:   Fri, 08 Dec 2023 16:10:17 -0700
Message-ID: <874jgs47fq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 31abfdda6527 (docs: Deprecate use of Sphinx < 2.4.x) in 6.2 added a
warning that support for older versions of Sphinx would be going away.
There have been no complaints, so the time has come.  Raise the minimum
Sphinx version to 2.4.4 and clean out some compatibility code that we no
longer need.

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
Only change since v1 is setting the recommended version to 3.4.3, as
seems to be the consensus for the best choice.

 Documentation/conf.py              |  2 +-
 Documentation/doc-guide/sphinx.rst |  2 +-
 Documentation/process/changes.rst  |  2 +-
 Documentation/sphinx/automarkup.py |  6 +-----
 Documentation/sphinx/cdomain.py    |  6 +-----
 Documentation/sphinx/kfigure.py    |  8 +-------
 scripts/sphinx-pre-install         | 10 +---------
 7 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 20bd74edcca9..3a1a804c3a13 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -47,7 +47,7 @@ from load_config import loadConfig
 # -- General configuration ------------------------------------------------
 
 # If your documentation needs a minimal Sphinx version, state it here.
-needs_sphinx = '1.7'
+needs_sphinx = '2.4.4'
 
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index bb7971643fcf..3d125fb4139d 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -28,7 +28,7 @@ Sphinx Install
 ==============
 
 The ReST markups currently used by the Documentation/ files are meant to be
-built with ``Sphinx`` version 1.7 or higher.
+built with ``Sphinx`` version 2.4.4 or higher.
 
 There's a script that checks for the Sphinx requirements. Please see
 :ref:`sphinx-pre-install` for further details.
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index bb96ca0f774b..559587a89974 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -58,7 +58,7 @@ mcelog                 0.6              mcelog --version
 iptables               1.4.2            iptables -V
 openssl & libcrypto    1.0.0            openssl version
 bc                     1.06.95          bc --version
-Sphinx\ [#f1]_         1.7              sphinx-build --version
+Sphinx\ [#f1]_         2.4.4            sphinx-build --version
 cpio                   any              cpio --version
 GNU tar                1.28             tar --version
 gtags (optional)       6.6.5            gtags --version
diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index acc6d55718bd..a413f8dd5115 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -7,11 +7,7 @@
 from docutils import nodes
 import sphinx
 from sphinx import addnodes
-if sphinx.version_info[0] < 2 or \
-   sphinx.version_info[0] == 2 and sphinx.version_info[1] < 1:
-    from sphinx.environment import NoUri
-else:
-    from sphinx.errors import NoUri
+from sphinx.errors import NoUri
 import re
 from itertools import chain
 
diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index 4eb150bf509c..e6959af25402 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -127,11 +127,7 @@ def setup(app):
 
     # Handle easy Sphinx 3.1+ simple new tags: :c:expr and .. c:namespace::
     app.connect('source-read', c_markups)
-
-    if (major == 1 and minor < 8):
-        app.override_domain(CDomain)
-    else:
-        app.add_domain(CDomain, override=True)
+    app.add_domain(CDomain, override=True)
 
     return dict(
         version = __version__,
diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index 13e885bbd499..97166333b727 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -61,13 +61,7 @@ import sphinx
 from sphinx.util.nodes import clean_astext
 import kernellog
 
-# Get Sphinx version
-major, minor, patch = sphinx.version_info[:3]
-if major == 1 and minor > 3:
-    # patches.Figure only landed in Sphinx 1.4
-    from sphinx.directives.patches import Figure  # pylint: disable=C0413
-else:
-    Figure = images.Figure
+Figure = images.Figure
 
 __version__  = '1.0.0'
 
diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 1fb88fdceec3..25aefbb35377 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -32,8 +32,7 @@ my $python_cmd = "";
 my $activate_cmd;
 my $min_version;
 my $cur_version;
-my $rec_version = "1.7.9";	# PDF won't build here
-my $min_pdf_version = "2.4.4";	# Min version where pdf builds
+my $rec_version = "3.4.3";
 my $latest_avail_ver;
 
 #
@@ -791,9 +790,6 @@ sub recommend_sphinx_version($)
 
 	# Version is OK. Nothing to do.
 	if ($cur_version && ($cur_version ge $rec_version)) {
-		if ($cur_version lt $min_pdf_version) {
-			print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
-		}
 		return;
 	};
 
@@ -842,10 +838,6 @@ sub recommend_sphinx_version($)
 			printf "\t. $activate_cmd\n";
 			deactivate_help();
 
-			if ($latest_avail_ver lt $min_pdf_version) {
-				print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
-			}
-
 			return;
 		}
 
-- 
2.42.0


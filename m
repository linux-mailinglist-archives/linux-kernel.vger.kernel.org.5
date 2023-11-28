Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF97FAF88
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjK1BaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK1BaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:30:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFB6E4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:30:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70E3C433C7;
        Tue, 28 Nov 2023 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701135019;
        bh=0rFWgVK0EFg6Nsa6a/EQ3Wk7q2M/kSfWg8x1h5DBihU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Arg2BfI3fBExEIRK2OQBaMUtoxslsQazNKrQYkWXGZp2xdlvhsbbmrzk9z1/6GbGA
         73vRa9/3FvEt/Iv4drpjgv74AP5ctUheZCsGeSNc0+awIJYwxxYp8eAzZSLJUTLuS6
         etHAxv/1VwwQbCidnzLhp0e6o4FXY9Ch23SRWo1Q047A1e37JqDscchXY/FItMCi9Y
         NCAg+y6GnAqedOHpSiokSJtRmUaixxZUfqBMS8T7vSnG8rhCbl1MOZKhTu45NE1vIv
         VbyfRj4pkNKoXZJf8pGgUJN/E9NfDY8bAlh5GBOux1NwVyFf8NRMMPr1WUdRHZohEj
         qntfofivLC1Mw==
Date:   Tue, 28 Nov 2023 02:30:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: Raise the minimum Sphinx requirement to 2.4.4
Message-ID: <20231128023015.0e446a06@coco.lan>
In-Reply-To: <87sf4qvkmc.fsf@meer.lwn.net>
References: <87sf4qvkmc.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 27 Nov 2023 16:31:39 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Commit 31abfdda6527 (docs: Deprecate use of Sphinx < 2.4.x) in 6.2 added a
> warning that support for older versions of Sphinx would be going away.
> There have been no complaints, so the time has come.  Raise the minimum
> Sphinx version to 2.4.4 and clean out some compatibility code that we no
> longer need.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/conf.py              |  2 +-
>  Documentation/doc-guide/sphinx.rst |  2 +-
>  Documentation/process/changes.rst  |  2 +-
>  Documentation/sphinx/automarkup.py |  6 +-----
>  Documentation/sphinx/cdomain.py    |  6 +-----
>  Documentation/sphinx/kfigure.py    |  8 +-------
>  scripts/sphinx-pre-install         | 10 +---------
>  7 files changed, 7 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 20bd74edcca9..3a1a804c3a13 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -47,7 +47,7 @@ from load_config import loadConfig
>  # -- General configuration ------------------------------------------------
>  
>  # If your documentation needs a minimal Sphinx version, state it here.
> -needs_sphinx = '1.7'
> +needs_sphinx = '2.4.4'
>  
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index bb7971643fcf..3d125fb4139d 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -28,7 +28,7 @@ Sphinx Install
>  ==============
>  
>  The ReST markups currently used by the Documentation/ files are meant to be
> -built with ``Sphinx`` version 1.7 or higher.
> +built with ``Sphinx`` version 2.4.4 or higher.
>  
>  There's a script that checks for the Sphinx requirements. Please see
>  :ref:`sphinx-pre-install` for further details.
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index bb96ca0f774b..559587a89974 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -58,7 +58,7 @@ mcelog                 0.6              mcelog --version
>  iptables               1.4.2            iptables -V
>  openssl & libcrypto    1.0.0            openssl version
>  bc                     1.06.95          bc --version
> -Sphinx\ [#f1]_         1.7              sphinx-build --version
> +Sphinx\ [#f1]_         2.4.4            sphinx-build --version
>  cpio                   any              cpio --version
>  GNU tar                1.28             tar --version
>  gtags (optional)       6.6.5            gtags --version
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
> index acc6d55718bd..a413f8dd5115 100644
> --- a/Documentation/sphinx/automarkup.py
> +++ b/Documentation/sphinx/automarkup.py
> @@ -7,11 +7,7 @@
>  from docutils import nodes
>  import sphinx
>  from sphinx import addnodes
> -if sphinx.version_info[0] < 2 or \
> -   sphinx.version_info[0] == 2 and sphinx.version_info[1] < 1:
> -    from sphinx.environment import NoUri
> -else:
> -    from sphinx.errors import NoUri
> +from sphinx.errors import NoUri
>  import re
>  from itertools import chain
>  
> diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
> index 4eb150bf509c..e6959af25402 100644
> --- a/Documentation/sphinx/cdomain.py
> +++ b/Documentation/sphinx/cdomain.py
> @@ -127,11 +127,7 @@ def setup(app):
>  
>      # Handle easy Sphinx 3.1+ simple new tags: :c:expr and .. c:namespace::
>      app.connect('source-read', c_markups)
> -
> -    if (major == 1 and minor < 8):
> -        app.override_domain(CDomain)
> -    else:
> -        app.add_domain(CDomain, override=True)
> +    app.add_domain(CDomain, override=True)
>  
>      return dict(
>          version = __version__,
> diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
> index 13e885bbd499..97166333b727 100644
> --- a/Documentation/sphinx/kfigure.py
> +++ b/Documentation/sphinx/kfigure.py
> @@ -61,13 +61,7 @@ import sphinx
>  from sphinx.util.nodes import clean_astext
>  import kernellog
>  
> -# Get Sphinx version
> -major, minor, patch = sphinx.version_info[:3]
> -if major == 1 and minor > 3:
> -    # patches.Figure only landed in Sphinx 1.4
> -    from sphinx.directives.patches import Figure  # pylint: disable=C0413
> -else:
> -    Figure = images.Figure
> +Figure = images.Figure
>  
>  __version__  = '1.0.0'
>  
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 1fb88fdceec3..db75b1b86086 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -32,8 +32,7 @@ my $python_cmd = "";
>  my $activate_cmd;
>  my $min_version;
>  my $cur_version;
> -my $rec_version = "1.7.9";	# PDF won't build here
> -my $min_pdf_version = "2.4.4";	# Min version where pdf builds
> +my $rec_version = "3.0";

Please don't. 3.0 version has a broken C domain, not properly supported.
The fixes arrived only starting at 3.1 (I guess some went to 3.2, but
3.1 is usable, as far as I remember).

With such change, feel free to add:

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

>  my $latest_avail_ver;
>  
>  #
> @@ -791,9 +790,6 @@ sub recommend_sphinx_version($)
>  
>  	# Version is OK. Nothing to do.
>  	if ($cur_version && ($cur_version ge $rec_version)) {
> -		if ($cur_version lt $min_pdf_version) {
> -			print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
> -		}
>  		return;
>  	};
>  
> @@ -842,10 +838,6 @@ sub recommend_sphinx_version($)
>  			printf "\t. $activate_cmd\n";
>  			deactivate_help();
>  
> -			if ($latest_avail_ver lt $min_pdf_version) {
> -				print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
> -			}
> -
>  			return;
>  		}
>  



Thanks,
Mauro

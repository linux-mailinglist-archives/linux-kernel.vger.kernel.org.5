Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7053D80B823
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 00:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjLIXod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 18:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLIXob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 18:44:31 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3E4137;
        Sat,  9 Dec 2023 15:44:37 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so2195359b3a.1;
        Sat, 09 Dec 2023 15:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702165477; x=1702770277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rtmQ0Co4x4OR8rVEqpmUzS6N/PIvHORpqyImpx7xIwI=;
        b=R/vDqZPAgYZDOUXm5YOgbHTAYVb94HDVYGLdrR8g0D90YyYtp5SAixk0mdZKrh1Dxx
         v6Tb1hf1BwtNY4ft7dcWRYyPexXsB2M3VCjvZnJaSUNTn9NO+UTZTzOlm9+NbBQ7D4KZ
         uUqJX3VwC8FFmyQuvdaW5mLFhgIcEPQY02QClVir1ZRhxALZOYsehyjb8SaS8YD/CiqB
         /X7cCKVaCuj87sAZUfoTses0Ku+5lPXo7Ntjx80uvvEsj2cw/FeY6mGoRoQocPTmrleS
         p7tAQ2m6rznUwGj8AOZ1N64Vl550CZwjYTRfnAM+PjS9YPXA3oJv13+55O1gumZqruCY
         NnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702165477; x=1702770277;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtmQ0Co4x4OR8rVEqpmUzS6N/PIvHORpqyImpx7xIwI=;
        b=NbnB5AKtlB/aEA0lP3nTfyY3b+foDRPW+f1gPD19xf+ep8N6aF3RcO8x+5sNPxhHEL
         JZ0aJcatliRp7v501peq6EFsCQyafZ+s1BTA3PmNiLMNIr7WMTiCqRAOR6CPXgv5C2m3
         mxWcaHLxTTJzIwNWf3215gcdTQIRzoIJGEN5/M1X3NbM0m8loe4y/T+Wwd8ESfeccXqM
         d/0GSjoODMnfn7SJdIJBEwm/nWNX0IJAk1jzF0PiIV74iUYXNN/v/jwujO6kaFVXVMaR
         GeM+Yt++JGzG+Ag/24PIxNMgqi1AUgVBM43jMKvCoY4TLKriJgGOWKZgO9HTgUlDst7j
         el1Q==
X-Gm-Message-State: AOJu0Yxqg40wzTAm4xqZjf+0VPyDTQ8KRaoQNWQ556eL1PFKmtncOlYy
        FKJOWdUmQlPrpN7aGXKQttQ=
X-Google-Smtp-Source: AGHT+IEiouUBxZ5U2tgoVTbnxXCZCzTcUY6iJ8p1/HvSrmbmZkSOERNVtlaAR0a62nrX/bRpcNAOaA==
X-Received: by 2002:a05:6a21:6209:b0:190:199:ba05 with SMTP id wm9-20020a056a21620900b001900199ba05mr2945399pzb.60.1702165476873;
        Sat, 09 Dec 2023 15:44:36 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p20-20020a63fe14000000b005c67721e6c0sm3698631pgh.53.2023.12.09.15.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 15:44:36 -0800 (PST)
Message-ID: <50830030-dca7-4c43-bcc8-449c7cfa9fbb@gmail.com>
Date:   Sun, 10 Dec 2023 08:44:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2] docs: Raise the minimum Sphinx requirement to 2.4.4
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <874jgs47fq.fsf@meer.lwn.net>
Content-Language: en-US
In-Reply-To: <874jgs47fq.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 08 Dec 2023 16:10:17 -0700, Jonathan Corbet wrote:
> Commit 31abfdda6527 (docs: Deprecate use of Sphinx < 2.4.x) in 6.2 added a
> warning that support for older versions of Sphinx would be going away.
> There have been no complaints, so the time has come.  Raise the minimum
> Sphinx version to 2.4.4 and clean out some compatibility code that we no
> longer need.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
> Only change since v1 is setting the recommended version to 3.4.3, as
> seems to be the consensus for the best choice.

With this patch applied, I get a confusing looking warning from
"make htmldocs" on a machine where the Sphinx version is 2.4.5:

--------
Warning: It is recommended at least Sphinx version 3.4.3.
To upgrade Sphinx, use:

	/home/akira/sphinx-2.4.5/bin/python3 -m venv sphinx_2.4.4
	. sphinx_2.4.4/bin/activate
	pip install -r ./Documentation/sphinx/requirements.txt

    If you want to exit the virtualenv, you can use:
	deactivate
--------

Looks like we need to update requirements.txt as well so that it
installs Sphinx 3.4.3.  Appended below is a fixup patch to that
effect.

        Thanks, Akira

> 
>  Documentation/conf.py              |  2 +-
>  Documentation/doc-guide/sphinx.rst |  2 +-
>  Documentation/process/changes.rst  |  2 +-
>  Documentation/sphinx/automarkup.py |  6 +-----
>  Documentation/sphinx/cdomain.py    |  6 +-----
>  Documentation/sphinx/kfigure.py    |  8 +-------
>  scripts/sphinx-pre-install         | 10 +---------
>  7 files changed, 7 insertions(+), 29 deletions(-)
> 
[...]

----8<----
From: Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: sphinx/requirement.txt: Reflect recommended Sphinx version

sphinx_pre_install parses the version of Sphinx in requirements.txt
and emits messages based on it.
Update requirements.txt so that it installs Sphinx 3.4.3, as well as
the examples in documentation.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/doc-guide/sphinx.rst    | 14 +++++++-------
 Documentation/sphinx/requirements.txt |  4 +++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 3d125fb4139d..5227a2611026 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -48,13 +48,13 @@ or ``virtualenv``, depending on how your distribution packaged Python 3.
       on the Sphinx version, it should be installed separately,
       with ``pip install sphinx_rtd_theme``.
 
-In summary, if you want to install Sphinx version 2.4.4, you should do::
+In summary, if you want to install Sphinx version 3.4.3, you should do::
 
-       $ virtualenv sphinx_2.4.4
-       $ . sphinx_2.4.4/bin/activate
-       (sphinx_2.4.4) $ pip install -r Documentation/sphinx/requirements.txt
+       $ virtualenv sphinx_3.4.3
+       $ . sphinx_3.4.3/bin/activate
+       (sphinx_3.4.3) $ pip install -r Documentation/sphinx/requirements.txt
 
-After running ``. sphinx_2.4.4/bin/activate``, the prompt will change,
+After running ``. sphinx_3.4.3/bin/activate``, the prompt will change,
 in order to indicate that you're using the new environment. If you
 open a new shell, you need to rerun this command to enter again at
 the virtual environment before building the documentation.
@@ -118,8 +118,8 @@ command line options for your distro::
 	You should run:
 
 		sudo dnf install -y texlive-luatex85
-		/usr/bin/virtualenv sphinx_2.4.4
-		. sphinx_2.4.4/bin/activate
+		/usr/bin/virtualenv sphinx_3.4.3
+		. sphinx_3.4.3/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
 	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 335b53df35e2..89329e67e788 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,5 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
-Sphinx==2.4.4
+# docutils>=0.18 is not compatible with 3.0 <= Sphinx < 4.0
+docutils<0.18
+Sphinx==3.4.3
-- 
2.34.1


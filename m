Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2C7F1D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjKTTzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjKTTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:55:37 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B10DC;
        Mon, 20 Nov 2023 11:55:32 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9ff26d7c0a6so155005466b.2;
        Mon, 20 Nov 2023 11:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700510131; x=1701114931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILX+BJpjSKYXyXiiLjvfzvXA9fZPPfuyaLaXpQSKHWM=;
        b=RbtATF23pvNfujJupUgp4mskaXmmjIB52o8DAY7x3nHguFXPsprOTv7YHbvyvH0hEy
         P34IDysQ7komM2bAI7wMyqpvggJuS8APiDsQqpGuPH3Wr7y1ScDB3VN0OqEpLZXybHvb
         LINWSqg53iPclDagv8aroALZPQr92d5jg2InaAwsb68ZkqwKHINj68brBqwYMghTaPq6
         emSAsIrH2nXdtso2f1GPvZxFxy6VMcYA78/dWxJCTxlkMlm3BQUxIMfphTnTTU/9D/k7
         nEe/sLswyxLs8+gdiLd9RBbxVqgiKmX6wzJFz5az37ukzNLqwr7zKvp1XtQxyaZajuH5
         kAEA==
X-Gm-Message-State: AOJu0YyPLA2q2YAxLT67pzmEz3iu19o7qmRMSPhrXpYtBiKCB6Ppez9G
        m8DnbDtJuGHXMJ7TD9LDuLc=
X-Google-Smtp-Source: AGHT+IEYRfWhaOPydo+cJgCSvFCQt4lgNST+TChjxonxA7gTVymXUZgohZHxW4c0vvnFlSJRyT5ghg==
X-Received: by 2002:a17:906:c80a:b0:9fd:cc75:3393 with SMTP id cx10-20020a170906c80a00b009fdcc753393mr3467635ejb.20.1700510130713;
        Mon, 20 Nov 2023 11:55:30 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906c00200b009fb1c3ce877sm2726104ejz.76.2023.11.20.11.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:55:30 -0800 (PST)
Date:   Mon, 20 Nov 2023 11:55:26 -0800
From:   Breno Leitao <leitao@debian.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     leit@meta.com, Jonathan Corbet <corbet@lwn.net>,
        netdev@vger.kernel.org, donald.hunter@gmail.com,
        linux-doc@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document each netlink family
Message-ID: <ZVu5rq1SdloY41nH@gmail.com>
References: <20231113202936.242308-1-leitao@debian.org>
 <87y1ew6n4x.fsf@meer.lwn.net>
 <20231117163939.2de33e83@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117163939.2de33e83@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 04:39:39PM -0800, Jakub Kicinski wrote:
> On Fri, 17 Nov 2023 15:17:02 -0700 Jonathan Corbet wrote:
> > In principle I like this approach better.  There is one problem, though:
> > 
> > - In current kernels, on my machine, "make htmldocs" when nothing has
> >   changed takes about 6s to complete.
> > 
> > - With this patch applied, it takes a little over 5 *minutes*.
> > 
> > Without having delved into it too far, I am guessing that the
> > unconditional recreation of the netlink RST files is causing the rebuild
> > of much of the documentation.  Even so, I don't quite get it.
> > 
> > That, clearly, would need to be fixed before this can go in.
> 
> FWIW on the C code-gen side we avoid touching the files if nothing
> changed both at the Makefile level:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/net/ynl/generated/Makefile#n28

I was able to do something similar and it works quite well. Only
regenerate what is not up-to-date. See below what I am doing. (I needed
to change the python to adapt)

> And the tool itself actually generates to a tempfile and compares
> if the output changed:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=2b7ac0c87d985c92e519995853c52b9649ea4b07

I am not planning to do it, since I would like to trust Make. Let me
know if you think this is important and I can do it also.

--
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2f35793acd2a..dad6e2ecf082 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -97,7 +97,22 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
                cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_stati
c/; \
        fi

-htmldocs:
+YNL_TOOL:=$(srctree)/tools/net/ynl/ynl-gen-rst.py
+YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
+YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
+YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
+
+YNL_YAML_FILES := $(wildcard $(YNL_YAML_DIR)/*.yaml)
+YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
+YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
+
+$(YNL_INDEX): $(YNL_RST_FILES)
+       $(YNL_TOOL) -x # Generate the index
+
+%.rst: $(YNL_YAMLS_FILES)
+       $(YNL_TOOL) -i $(patsubst %.rst,%.yaml, $(@F)) # generate individual rst files
+
+htmldocs: $(YNL_INDEX)
        @$(srctree)/scripts/sphinx-pre-install --version-check
        @+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))

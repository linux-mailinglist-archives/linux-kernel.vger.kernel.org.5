Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591AC792B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbjIEQzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353492AbjIEGYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:24:35 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53F191;
        Mon,  4 Sep 2023 23:24:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-56b0c5a140dso1552640a12.0;
        Mon, 04 Sep 2023 23:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693895071; x=1694499871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZe9XtPeDijJTfBrAmZ3rs+0VNHgiBDEk7wGRdjI3c4=;
        b=Q0NIVVx+L5/0TPSpLLuPQCkGsCtCDePKeJzGBpMSzTmOL/G+1I2qTTO8ot49oZ23Jd
         7c3XkkeG01gP4h5cOolHCERRl9U+8//zpzE+hp4iO+2224FT4Pd9TGOUg/om7I40e6x3
         o28YPA6YWh4K9yMB/j7+QfV5RrkGXct4Qrz1QH0q0g3HylPKIMkpIt739TVdFhBHfkX7
         K/+DbuVaESTX6vmw9pYox6w1OTS8DliHjoaWnLBRLOtLkl3z/y2rjmHFTxitimjupNbs
         H+RBOlxcr1Nh1p+0nFbMQ/6H2V0KmhJcXmOwZB3NHWxtzX0dMLd2lRBhhXi6oyN4yCA4
         TpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693895071; x=1694499871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZe9XtPeDijJTfBrAmZ3rs+0VNHgiBDEk7wGRdjI3c4=;
        b=GZiS2Pa5U5PxKxRgDk7k9YeN0G927CaDwrVvKgF8XnSjPKQjUZBtgvfTIhWEC/2b7s
         yx31pSTuRg8TKqxDK/3N1Yi1+rdzj/3xflbF3hyXRmQ0W8E1gpXiwXvr/Sq+wClCTGQK
         DJNVK4bcHEPXG1+HAXQ+IH5mhZRXoveAoCkLpeTYeGi3gqqaB9kuiu5vynpz3dRJtCCY
         d4aIjppeCLYO36YZPieO7RDnX17vQol4oJ+OobNDFMWv6s8p0a2Ub04Oc7kWTr+G6iFe
         /pQTwpuG1u4tYmGKLiGcbO4bbWhgo1rhU96Ti08XmBEdK5KdyAXQP99G8Ugj8PI19lnn
         gvXQ==
X-Gm-Message-State: AOJu0Yy1++/1f4g+sfojRphnGiTdRGRV9+q4PpWoOhAPdM/GfsN+qG4a
        4nwTOTWrGO8JW3GhUUm2S7M=
X-Google-Smtp-Source: AGHT+IF+MDQa2Y721EGnUs4M/DkAWziEdIlV8HdGxLhcRV71seoYweMUgY5Oosud0dFN4iHAX6FM+A==
X-Received: by 2002:a05:6a20:7491:b0:12e:73bb:cbb6 with SMTP id p17-20020a056a20749100b0012e73bbcbb6mr15530522pzd.14.1693895071456;
        Mon, 04 Sep 2023 23:24:31 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001bd41b70b60sm8526721plh.45.2023.09.04.23.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 23:24:31 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     peter.yin@quantatw.com, Peter Yin <peteryin.openbmc@gmail.com>
Subject: [PATCH v8 0/2] Add Facebook Minerva (AST2600) BMC
Date:   Tue,  5 Sep 2023 14:22:20 +0800
Message-Id: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
Correcting the arrangement order in Makefile.
  +	aspeed-bmc-facebook-greatlakes.dtb \
  +	aspeed-bmc-facebook-minerva.dtb \
  +	aspeed-bmc-facebook-minipack.dtb \

Correcting the arrangement order in Document
  +            - facebook,greatlakes-bmc
  +            - facebook,minerva-bmc
  +            - facebook,yosemite4-bmc

Remove redundant blank line.
1.
  +	/*P4-P7 line 248-255*/
  +	"","","","","","","","";
  +};

2.
  +
  +// SOL Host Console

3.
  +
  +//BIOS Flash

4.
  +&uart2 {
  +	status = "okay";
  +	pinctrl-0 = <>;
  +};

Use stdout-path.
  +	chosen {
  +		stdout-path = &uart5;
  +	};

Fix dts path.
  old:arch/arm/boot/dts/
  new:arch/arm/boot/dts/aspeed


*** BLURB HERE ***

Peter Yin (2):
  ARM: dts: aspeed: Minerva: Add Facebook Minerva (AST2600) BMC
  dt-bindings: arm: aspeed: add Meta Minerva board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 377 ++++++++++++++++++
 3 files changed, 379 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts

-- 
2.25.1


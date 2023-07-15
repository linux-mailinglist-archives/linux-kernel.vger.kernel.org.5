Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC8754A3B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjGOQzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOQzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:55:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D2FFD;
        Sat, 15 Jul 2023 09:55:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e64e97e2so2147609b3a.1;
        Sat, 15 Jul 2023 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689440140; x=1692032140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubGyv1/Ygc3r0aejvSCA4OLowIeO/QtJDtMmWSuLbbA=;
        b=fzrnUjCr7PbCvdmX9z+HiWchCOfsiRzoqKnSIEyCXGwDe/iSWnthmjiOtjoalVTaiu
         bwDrRhoAvkYJ88WYaQ4rfd11vj7znKX4TLilqXyxFWTOWcM8tSSaqJecr+CAdIlrmNy5
         iuRrAAxeF8d70ZxNirl/zOrR7EnUA9Ye4e90QdRxIxrCOLyhtmtyeKIuQXKxi7MiUXzv
         qvNbVuQahDlB2S4OTtPx/bFhv+7uo3DKEW0NqSGFtkYhV/NQxUCsxiSiwNIsKZd6Q8wk
         +lXOVoU5cCVHR5uan3DOc8ngVbwt5GheOlu0mJkEl+bqoVZC4oSDsFOmK5nO/JzqYFCC
         q3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689440140; x=1692032140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubGyv1/Ygc3r0aejvSCA4OLowIeO/QtJDtMmWSuLbbA=;
        b=QmuQKN6K94p5ZdzLfCCJzYf5SheGtL6Y3m9/Fs9wH9plQMymXWtP7iNmcLnlgIcKdw
         QWa+4Q5JsP7u4mOTbpPLB2xpXW6vufJcPtwci8Ow6Rxwtp/no1ZYkH1bePTaEyHbeeh2
         ISaG6ykkPIAO+Z34recocK77L/isXjmX7GffhBrTlKRiTxk2AIAnGlu6t+J8TWKDd6UT
         2hZHE5Zv+raKFd213MoxEoZLTPGLwPwa0qbTAMZGsjC4JZS6F13DV2Gi1ESw/jc29KdQ
         MSeT0uGo5CEZgQV4YKzZOdzCRc4YqLMJ2xIYexYV3EaWoyVDZRMFHRQ66dET6gltW+ha
         v/cA==
X-Gm-Message-State: ABy/qLauNy0KMG3TaGLqJOHf/faeuoV0LzldqKofIZaSpNSHY+sjn8rl
        Kje1lMPlH4giOZrDwkUfrpq02M2ADLE=
X-Google-Smtp-Source: APBJJlGDhaXWS+ae0J4ItsPOsBi6CjK6+MtngxLk1oc11DllicWU7qKMFYrUsJaRbQsY0y/1bBTzSA==
X-Received: by 2002:a17:903:455:b0:1b8:a4a9:6225 with SMTP id iw21-20020a170903045500b001b8a4a96225mr6961436plb.7.1689440140062;
        Sat, 15 Jul 2023 09:55:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f28-20020a63755c000000b005501b24b1c9sm9419828pgn.62.2023.07.15.09.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:55:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 15 Jul 2023 09:55:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] hwmon: Explicitly include correct DT includes
Message-ID: <e0e1b465-8419-419e-90ae-4b72f5189469@roeck-us.net>
References: <20230714174607.4057185-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714174607.4057185-1-robh@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:46:04AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

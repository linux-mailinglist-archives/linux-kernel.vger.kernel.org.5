Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F97BA98E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjJES4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJES4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:56:35 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03EBA6;
        Thu,  5 Oct 2023 11:56:33 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79fa387fb96so57226239f.1;
        Thu, 05 Oct 2023 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696532193; x=1697136993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+7ZgmwvHcd4XxtyCW9lIWtoj/cz+ZOFOOkfV4f6hwY=;
        b=UZdbWDMJzZHbuNGAvpBjHzXdy/eNa6g6HCZ6YEWGy/0/+iJeR3uf0Q39JeNNgolNm2
         dlO3K0FfCER/2T1qFvzgSflRdpaZ+7w15+1syQEo1NS/v1Dz9EvVQqawamMcyItP/dRA
         FtuBKhcK8sA2xvjHXF+NMUMgcDIsmNfpdvp5ODUUBtcxJ6O+HpjXAH58IYa4LSaQSQw3
         XmHwq11aFyKPhdyDQTrVUwzir5b7UlGxGnVsSxbniIjB3WnhZtURkhC6oU2Rd4QbOyfN
         svsitDB4x5k8JfJCSPKXFOvCZLGVGCQ68rCIlUClnsFwcJjs+zAuH5IIrpSTaPz1UXFc
         wrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696532193; x=1697136993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+7ZgmwvHcd4XxtyCW9lIWtoj/cz+ZOFOOkfV4f6hwY=;
        b=ADFRQsGkv2fSzfWwdTKE09kNpbRrCyDlWGB/xAaMsMVNOgLmMBOfonDylIGVsGrdM4
         AjMuVznY3aGA26Scy9QlvELudfO3gRbCFR1eiEIIZsct7jBj6KvC5svmynETRbOnB9wB
         uc9NCVW/qliv8hFXDjhoLpNlGrqTqYZw8nH7FeTgYIzYTZhJMeX58H1/955YJK6eUkJY
         7RjAbxQHjUqIW0g4D2nTd+CuJRAUX8iKMP6gavln4ZO00mhvO96mQPLN584mawkv0+Pg
         motj/dWfOQfoCRAWzefIvdBwCqKZl+yqemvzp8k4Aio19CLaDtNTnR2lybcmQbLuoxgm
         eZ8A==
X-Gm-Message-State: AOJu0YzjPMpKE2gQCp2bv0zZ/MVLMAanMWQNTVnSGCqEZbd0H0SH39LG
        7qesW+qWIYP8hjv1OQN194MfwOhDQJo=
X-Google-Smtp-Source: AGHT+IGLqW1KUSqWfnlmuxfLfSwgQHNDempCqj+PzjKHkCYmu7jiD94Yf4YTQxwsN/vFVi28Ga9pNg==
X-Received: by 2002:a6b:e50b:0:b0:798:134a:44b with SMTP id y11-20020a6be50b000000b00798134a044bmr6447031ioc.21.1696532193018;
        Thu, 05 Oct 2023 11:56:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17-20020a0566380a5100b0042b1dd89b0bsm100832jap.155.2023.10.05.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:56:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 Oct 2023 11:56:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Ober <dober@lenovo.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [External] Re: Watchdog patches
Message-ID: <febf1090-67bb-4081-8010-35acf8a26952@roeck-us.net>
References: <SEYPR03MB7192579DF7D0130F699CB7D1DA09A@SEYPR03MB7192.apcprd03.prod.outlook.com>
 <3c51b285-6691-14e7-e3e3-9e111e8561a8@roeck-us.net>
 <SEYPR03MB719214D0CFFAA04B17748321DACAA@SEYPR03MB7192.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR03MB719214D0CFFAA04B17748321DACAA@SEYPR03MB7192.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 12:18:50PM +0000, David Ober wrote:
> Nudge, I now have three watchdog patches pending and no updates on what may need to be changed for any of them, any update on what needs changed as to why they can not be promoted to the main line kernel.
> 

On my side, there is a severe lack of time, combined with burnout due
to a large number of patches requiring several rounds of review and
feedback. I do not expect that to change anytime soon. If that is
unacceptable, I'll be happy to resign as co-maintainer of the watchdog
subsystem.

Guenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15787EB168
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjKNN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjKNN6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:58:06 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA1E1994;
        Tue, 14 Nov 2023 05:58:01 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1efb9571b13so3448510fac.2;
        Tue, 14 Nov 2023 05:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699970280; x=1700575080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tQ/w7U1rEr9pNLfzZT/Ukv2lbglG63Hd24Y7omCEu8=;
        b=ndMYdRBhuGzs5m5r28ytpRzeCtq/wT08uE1WROpgLj35wkx2BYuGGzGqkvCAKK//Oe
         JdRVIqA/t1+/Ud6AwnfUvody+0anHf4qXmJLeQi2tGF9hwvsFLTWB9rLATzBxOHmQQeX
         SbtUJtObHIEMN4w0DXFbffnR5u4WF61AkZbw3679UPS893bHBo6m5GUZiLR+i5CcanYg
         ZWVLepKDJMg0W16hR+PFSOq6ocbmh4W5HTU/7deDNuvsa1nbXQKbkgfla/HjGkNU/jCp
         niSrSoMxVdrbzjXDXHI/Uum5e3Oj444D0vFlgj9iW6b0jRFdO2AlOaueNLFo9K4Tr9Tw
         xFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970280; x=1700575080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tQ/w7U1rEr9pNLfzZT/Ukv2lbglG63Hd24Y7omCEu8=;
        b=rYVUQHwxAKVF2jviGDxXLWEoWaPBiFp2m0w3TAte5CalkheOU119CaJMgoeL5O33ru
         ta8NtvtVXSN/jzqPpGmMAFAQf8wUwgCwT9GDbTWjGCwhLRW2WXKJGFYsgWicpR5/MI3/
         7ifXh7/2WSaaul6p6WfNVy1HBiu5OvWcvcwwvWFJMUkdSY4wQ7IScKb97mcsIJjMlI1C
         1R9OrVrmwPjXZbS1BsYqddzSliFHp0UyRxfDSKgq0jUA7WCdSK1XvZuAjy2AzqIcdiu5
         lSNKdGvLZCSgSC7lob6SXt/JIARpqSq1nlPZmZIoOH5cpElhoT85i19tscod646BeOHL
         53Yw==
X-Gm-Message-State: AOJu0Yy4ruQSG5F51IZhIldWwgoKRhfpuUz1uHv91PKNQJPK4SnbtmDj
        wW1mBt93uJH3amXr68gnJnPyBq+LYOA=
X-Google-Smtp-Source: AGHT+IG2kwx3olSWgkhoI21eWtGCUJjtnOwNM1Yb0dfCZ782WdZE4B0kmJy6laSkiHWN9lbI0DZggQ==
X-Received: by 2002:a05:6870:1494:b0:1ea:bb5:a531 with SMTP id k20-20020a056870149400b001ea0bb5a531mr12651796oab.13.1699970280553;
        Tue, 14 Nov 2023 05:58:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a07f500b007759e9b0eb8sm2686217qkk.99.2023.11.14.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:58:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 14 Nov 2023 05:57:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] hwmon: (dell-smm) Add support for WMI SMM
 interface
Message-ID: <149a31b1-f5b8-438c-8883-987cb4224944@roeck-us.net>
References: <20231106064351.42347-1-W_Armin@gmx.de>
 <3ec0496d-3b89-46f5-9faf-9fcce78f6b38@gmx.de>
 <8c25dfec-b0ca-4e2f-964a-5ae62452e141@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c25dfec-b0ca-4e2f-964a-5ae62452e141@redhat.com>
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

On Mon, Nov 13, 2023 at 09:17:48PM +0100, Hans de Goede wrote:
> 
> I plan to review and hopefully merge this and your
> other series sometime this week.
> 

What warrants merging this series through your tree(s) instead of
through hwmon ?

Guenter

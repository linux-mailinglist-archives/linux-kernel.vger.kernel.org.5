Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291E17F32F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjKUP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjKUP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:59:24 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CE191;
        Tue, 21 Nov 2023 07:59:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cf62a3b249so15271055ad.0;
        Tue, 21 Nov 2023 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700582359; x=1701187159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LYyNKkmX/uEHFZv6ne32wpjoPjS3cMG64F7aftHlMU=;
        b=b1g3H9ml79e9USUT9B2j2158wbfqoetH9dfEigld+f9KpmnSe+5cv45iy2gq7mHkjp
         OKRaMw1zS7N4fHSaN6lP0l97iGk/lFk2cM7v6OfbLy5Brnx7+xmulxVHQLvX6dx+ILjt
         b/b9c+Jg95jSyoYif9ReTz2cMBn++6hzstNJn4+2NUqscq6HVBJhJkdNTo1c7fIIsLq4
         r5GmtTeCqLPs25QEktNLzSQgJ5L5+Cc/kjrzmiDgGUKI7wPNPOpNVVsl7UdkhXtKX/iT
         OjdOO3kExxTGT/P/d2vnGnSdqMsA1p8AYxAUQL6wgMdfRhVmwUnyFc+4d2NrqPCaS4eF
         8lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582359; x=1701187159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LYyNKkmX/uEHFZv6ne32wpjoPjS3cMG64F7aftHlMU=;
        b=I1RDU1cjbB08cpl2HJRPq3T3lP+GmW8u+qR2F/TLCnPCX8lU3FQD7HpDJkDdT7Qyll
         gSrnpwaqQKBdAEL8KwPuw1TBOouIPN29nsmIijKfdoLXGqgh1VQ7TorZaQEND7n7v0ZX
         /iBAEbmw3Q/AArSeCnubZCdOeTPMcUH3s8k6S/QBmd/gbLa+0m3ZY1M0WzbZDK8r9s2o
         wmTnmch/dchw/lyDmiVRVHXewEh6L4GZkhiOJo2wkwrNTH5uKOuNxF7mj1L+X8s07j9a
         pRCBE7An/NSdX75jedaP0me+0VuBJKLDfT0hSxs/rHzoGoZPM08sFXjkuOmpxP9a7g/t
         7hzA==
X-Gm-Message-State: AOJu0Yy1Z4V6/tyF4bO0RdranG51PyMRI+PWoiH7Dx3dzo9N6fy/XXPl
        7H9AaILnP96JHIukzO3pawE=
X-Google-Smtp-Source: AGHT+IEruKQliG6flmHqnASEhkc2Xm19UStJK6nxzq22+KzG0YLwvHxxxPxKBtcQYRi7HbInd2BhaA==
X-Received: by 2002:a17:902:e546:b0:1cc:4669:c0eb with SMTP id n6-20020a170902e54600b001cc4669c0ebmr11057412plf.21.1700582358656;
        Tue, 21 Nov 2023 07:59:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902d50e00b001c898328289sm2035486plg.158.2023.11.21.07.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:59:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Nov 2023 07:59:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xing Tong Wu <xingtong_wu@163.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com,
        tobias.schaffner@siemens.com, gerd.haeussler.ext@siemens.com
Subject: Re: [PATCH v3 1/2] hwmon: (nct6775) Add support for 2 additional fan
 controls
Message-ID: <d51bdd07-8ea1-4f33-a205-168dee6d5992@roeck-us.net>
References: <20231121081604.2499-1-xingtong_wu@163.com>
 <20231121081604.2499-2-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121081604.2499-2-xingtong_wu@163.com>
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

On Tue, Nov 21, 2023 at 04:16:03PM +0800, Xing Tong Wu wrote:
> From: Xing Tong Wu <xingtong.wu@siemens.com>
> 
> The nct6116 has 2 additional PWM pins compared to the nct6106.
> Extend the nct6106 PWM arrays to support the nct6116.
> 
> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>

Applied.

Thanks,
Guenter

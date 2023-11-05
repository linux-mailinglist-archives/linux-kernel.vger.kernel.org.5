Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2307E176B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjKEWrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKEWrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:47:36 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0B7CF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:47:32 -0800 (PST)
Received: from [192.168.68.112] (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B6F3620075;
        Mon,  6 Nov 2023 06:47:27 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1699224448;
        bh=1TOTltR3bb+XNIcf27UXTOFQ8YANP5VzWaRS1UXoM6Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=iSTSeyawJ3UzDutlcUbEk3WiscArwc1m6oIpSlJyo4d7gzXgnvaIOBhgAfpqzCEzt
         ev7V7Jufa5EFTReWvdFoUcM7/Q+KaCKd0mJq0zadqwjYxDufl8JnJpLcxpuzC8PSx3
         U45Abq69F/CWosT5gWYCRQV6DaNJx/1/ykmt39guPj+map1AQTV001RZ+SJaKgXV2s
         t/kP/HMV9u1K0PYKXXSImIeXP8LtUQ1B365HL0Fhwue+ipCWbS9+cr1xmhAN1Yx3UW
         IsT4NPVrdnpmBOhkjnyJi5k4lA2+mc72WgsDuz8fM+i+6VBPXHcAL1nWYt0a9OV3ON
         h5wkiYTzyl43g==
Message-ID: <d1ab4c5b175099fc204909e5430c87fb55565e56.camel@codeconstruct.com.au>
Subject: Re: [PATCH 02/10] ipmi: kcs_bmc: Include spinlock.h
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, aladyshev22@gmail.com,
        jk@codeconstruct.com.au
Date:   Mon, 06 Nov 2023 09:17:26 +1030
In-Reply-To: <20231103143657.0000046f@Huawei.com>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
         <20231103061522.1268637-3-andrew@codeconstruct.com.au>
         <20231103143657.0000046f@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-03 at 14:36 +0000, Jonathan Cameron wrote:
> On Fri,  3 Nov 2023 16:45:14 +1030
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>=20
> > struct kcs_bmc_device defines a spinlock member but the header in which
> > it is defined failed to include the spinlock header. In the spirit of
> > include-what-you-use, do what's necessary.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> This is fine, but whilst checking it I noticed there is no
> forwards def of struct device or appropriate include.

Ah, I'll fix that too.

clangd automatically added the spinlock include at one point and so I
figured I'd capture it.

Andrew

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B17F85CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKXWJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjKXWJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:09:36 -0500
Received: from mxout017.mail.hostpoint.ch (mxout017.mail.hostpoint.ch [IPv6:2a00:d70:0:e::317])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80750198D;
        Fri, 24 Nov 2023 14:09:41 -0800 (PST)
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1r6eMf-0008gT-0F;
        Fri, 24 Nov 2023 23:09:33 +0100
Received: from [178.197.218.170] (helo=thinkpad)
        by asmtp012.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1r6eMe-000J7e-2h;
        Fri, 24 Nov 2023 23:09:33 +0100
X-Authenticated-Sender-Id: code@stefan-gloor.ch
Date:   Fri, 24 Nov 2023 23:09:31 +0100
From:   Stefan Gloor <code@stefan-gloor.ch>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: sht3x: read out sensor serial number
Message-ID: <20231124220541.gvyaf7cbtc3kbesr@thinkpad>
References: <20231124145519.11599-2-code@stefan-gloor.ch>
 <52909c46-4699-442b-9303-ec914fba093b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52909c46-4699-442b-9303-ec914fba093b@roeck-us.net>
X-Vs-State: 0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

thank you for your comments.

On Fri, Nov 24, 2023 at 09:34:48AM -0800, Guenter Roeck wrote:
> I am not going to accept this as sysfs attribute. Please implement
> using debugfs.
> 
I will do this in V2.

> 
> Also, the attribute (sysfs or debugfs) should not exist if not supported.
> Please only provide if supported.
The driver is currently only compatible with "sht3x" and "sts3x". 
As only a subset of these support this feature, do you recommend I
create new additional device IDs, i.e., sts32, sts33 and sht33?

Best,
Stefan
-- 

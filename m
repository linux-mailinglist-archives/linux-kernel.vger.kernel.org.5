Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049657AE185
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjIYWGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIYWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:06:50 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55035AF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:06:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEC76240002;
        Mon, 25 Sep 2023 22:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695679600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gzCw6ra0zn/1by6znFNr5xFHVbxNOnnCrhXAzuwYZP4=;
        b=XudPymtt8i93KyLNlWn6HvF103CntmQ3dSUDVMG8Nt99hvWn5t8nl8BYV2LfrzJkIa25qJ
        UeWuBcD5J3DyxXM/+AxO1ni+5kAjauSMuh5q6JovqokH6SriRtRvQNHisnFHJD04gmbQWK
        j8elGrMuV/A10VG6ztBF2HoEDWwPpW8aBFZEVTrEqu8LVOhamfbSHpFs46H4catXNjGgCC
        6XemR1oPJ+KHCNOqGqB42iSrMNPJ/Yxr8ZKZSeVU5eRWmUves+KxYavenY5K077U/eJukK
        m0EZYBCp2aCJwpUgLfMUgz5N9tAEOEoK6X9StmWLItYaNSkxgVBSD07qkiuZOg==
Date:   Tue, 26 Sep 2023 00:06:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: Fix potential refcount leak in
 i3c_master_register_new_i3c_devs
Message-ID: <169567834167.244864.5680434544553157892.b4-ty@bootlin.com>
References: <20230921082410.25548-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921082410.25548-1-dinghao.liu@zju.edu.cn>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Sep 2023 16:24:10 +0800, Dinghao Liu wrote:
> put_device() needs to be called on failure of device_register()
> to give up the reference initialized in it to avoid refcount leak.
> 
> 

Applied, thanks!

[1/1] i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs
      commit: cab63f64887616e3c4e31cfd8103320be6ebc8d3

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5093E7F42FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbjKVJ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:58:27 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853CE3A80;
        Wed, 22 Nov 2023 01:58:21 -0800 (PST)
Received: from hillosipuli.retiisi.eu (185-9-10-242.cust.suomicom.net [185.9.10.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SZxWr1J0dz49Q5M;
        Wed, 22 Nov 2023 11:58:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1700647097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=px2t06fELUfVVy3XiuKAZt/oCF+Z0H9P1brr1DuVzMA=;
        b=YcpDCYk0XSrrqXC8M3udS3dCH/LgJNgOGNxR0r/3EwhVCDnMqLmgrtwPQDUDcpo0xxaiVK
        BmoEKLAEcANNxEBFFBpExMarWuTU6wFkxtktCu8s5j4VmkagdD+8hYT6Zho59AwV5DTojg
        SEAdP05K6LSAwM9Nh7mkb5Bmbc3wqf/s90xQp4ofTnFA1WUDJjNhiXtGPURVHfaXmZ4kTw
        L8Oaqq86tdzqzSFY1noIE2oaPHc/JeMPBgpdiNEc2ha1sAfMcou05jop+8chsjCy6DsyoO
        L+TL+tXXIPHcmZ1XkNNpWWYbpziME5cxslnzasHzETLR9HsNXD6SOg5P7NKvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1700647097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=px2t06fELUfVVy3XiuKAZt/oCF+Z0H9P1brr1DuVzMA=;
        b=INUoqTMXpigQ8jPL7nyyYnmkuiPgstQEuBdZpagQ8QydnnO6axAv9T7jBGSzTU6Bexr9Ue
        QyeZRB5fRex1k9hUTKyKrPbNEtS5h3WamdDIQIbCzwTonAhbrcJnbWaGSGHbrY190vB12J
        e6xhP0OXp0jgA9JjsnrYaXvLnxUgw/BViJyJ20cfrg3ROGdnZVqjNV8xj/LTV1nc09gkqY
        VbeWS20mj09lJxNHO1kNk2qxgXuuhjrFeWx1g2rnn9WPa9iHU9pyGC0Ud4U+GSz7K4NtnH
        lMCvWdrNdBMJ252A81b6Khvvln+w/Pu2Dvr/RT9RLZAOv3lGlJqiF4MvNGA2SA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1700647097; a=rsa-sha256;
        cv=none;
        b=r+PG7yKvdmIZPzdfNz0LthHSEQeWFsjF6nfQg6BoDO/iuUvW2pgtTbc7d4yz93nGTYA7AD
        YO3/XtPSv8ukVkmRmj+F68d3F/LeN84jV4LkLQcqIZQrE4nf+KjiIOtOdxWCJ1T5I9IXpa
        aTL2M1VH+eHg8MyvaqCiy0haYBhDjsRwOBqvD7s1LLCzAgzEPf0yYV2IAT5AY2TXgUh3T9
        sb678dV+oL5tcyznnbMDs7hbYORFkeVLVyS509v86Sqpy9tljcqSsjuxtyCO4NGWWQhwbz
        ThHTg2OQRYrVYgzzV3cDrGtVf0j/emAuU4qINtHLr+EuNL0oLJto9OIGJDox0g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id F33F0634C93;
        Wed, 22 Nov 2023 11:58:12 +0200 (EET)
Date:   Wed, 22 Nov 2023 09:58:12 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 1/3] media: uvcvideo: Always use uvc_status_stop()
Message-ID: <ZV3QtDOLj-6js07v@valkosipuli.retiisi.eu>
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-1-d8a5eae2312b@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-guenter-mini-v3-1-d8a5eae2312b@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Tue, Nov 21, 2023 at 07:53:48PM +0000, Ricardo Ribalda wrote:
> uvc_status_stop() handles properly the race conditions with the
> asynchronous worker.
> Let's use uvc_status_stop() for all the code paths that require stopping
> it.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

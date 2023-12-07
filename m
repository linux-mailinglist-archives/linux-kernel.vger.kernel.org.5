Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA84809675
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjLGXNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGXNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:13:35 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACD91712;
        Thu,  7 Dec 2023 15:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YDjuHr+EiLsC36JvvpPN8T8VswhgDUJmDxpL1zCg9Yo=; b=XTMB/ie0P9ynAj6SNJb6fr5brI
        CKBhczXqgQi0FPzECQNQxmvWxaRtj+z7UdYWjBFrZzGO/xnO9xK+SOwstcfgg0awdsT1ip6kf8blN
        JxNtS1XjUTknJ/T2luHtEh56MW6Ymut/yDaasoJSm8quG5wcDlVKfLiYFYc9uPenwA8gVERyL0MJY
        EXLzG4WO5jXVM1fW1RGg/yvnbRtjVIX3TsAiNJx2HPCCzvNI5W8AKfMYZBrGeVX698FA6P/8BXz3C
        dy8+/MSt6gqaQgOdJKa+wE7Ihs9pPilSRDHlF6Rx0ni2IOpCLfG5mM3kx34l2wUfjgMkplfE7TsY2
        HRWPcOFw==;
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1rBNYk-0079Mb-K2; Fri, 08 Dec 2023 00:13:34 +0100
Date:   Fri, 8 Dec 2023 00:13:32 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 5/6] mfd: twl4030-power: accept standard property for
 power controller
Message-ID: <20231208001332.1f9e062f@aktux>
In-Reply-To: <20231207171341.GH111411@google.com>
References: <20231203222903.343711-1-andreas@kemnade.info>
        <20231203222903.343711-6-andreas@kemnade.info>
        <20231207171341.GH111411@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 17:13:41 +0000
Lee Jones <lee@kernel.org> wrote:

> On Sun, 03 Dec 2023, Andreas Kemnade wrote:
> 
> > Instead of only accepting the ti specific properties accept also
> > the standard property. For uniformity, search in the parent node  
> 
> Search 'in' the parent node or 'from' the parent node?
> 
> Where is the property?
> 
The idea was to have the device tree property at the same place for all
twl family devices. So no distinction for these devices needed
in the bindings. It is in the main node.

I guess today this twl4030-power subnode would not be accepted nowadays
and the compatible would be some kind of flag in the parent.

> > for the tag. The code for powering of is also isolated from the  
> 
> Should this be "off"?
> 
yes, of course.

Regards,
Andreas

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7D7FAAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjK0Tvt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 14:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0Tvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:51:46 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C55D60;
        Mon, 27 Nov 2023 11:51:51 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r7hdy-006mkA-4B; Mon, 27 Nov 2023 20:51:46 +0100
Date:   Mon, 27 Nov 2023 20:51:44 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Adam Ford <aford173@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        johan@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ideasonboard.com, Tony Lindgren <tony@atomide.com>,
        =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Subject: Re: [RFC PATCH 0/3] bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20231127205144.2137de38@aktux>
In-Reply-To: <CAHCN7xL-HjK4WGVB7xHxWjAR0h7U6SLViLfWgur7Vc-bvf43+w@mail.gmail.com>
References: <20231126191840.110564-1-andreas@kemnade.info>
        <CAHCN7xL-HjK4WGVB7xHxWjAR0h7U6SLViLfWgur7Vc-bvf43+w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 08:03:24 -0600
Adam Ford <aford173@gmail.com> wrote:

> On Sun, Nov 26, 2023 at 1:47 PM Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > Some of these chips have GNSS support. In some vendor kernels
> > a driver on top of misc/ti-st can be found providing a /dev/tigps
> > device which speaks the secretive Air Independent Interface (AI2) protocol.
> > Implement something comparable as a GNSS interface.
> >
> > With some userspace tools a proof-of-concept can be shown. A position
> > can be successfully read out.  Basic properties of the protocol are
> > understood.
> >
> > This was tested on the Epson Moverio BT-200.  
> 
> Can you tell me which WiLink chip this uses?
> 
> I'd like to try it on the WL1283, but I want to understand which
> WiLink chips you're targeting.
> 
I think, it is a WL1283 here, too.

If you want to play around with it now:
- set the devicetree node name to bluetooth-gnss
- for testing you can use the read-gps program at https://github.com/akemnade/bt200tools

Regards,
Andreas

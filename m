Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5366580C6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjLKKeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjLKKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:34:18 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005DEC2;
        Mon, 11 Dec 2023 02:34:23 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB38B40003;
        Mon, 11 Dec 2023 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702290862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9L21AQYqeLtrd6Te3qKxaQsyKEoZO7Rpnlua51IlF4=;
        b=LzCJMzmZuVnPiCKJJU4FltLShfzWPAVVTYYk7C/QA0cB11QGbsAEdriYKymiy/U7OSlsHs
        q+EiIj0RGGiF1sSetVQDMxXHhAzB4GCmnb1icpvfKYIFCEXxPrMBUAOzRIKp6YAG2P9caB
        yD1USF0hwj3lPqxU78/bADqvoU+lVa4BmEEODVDbl5nm9L2YjlKaraYnOI+tjm8vYLCwPk
        BoegAW0cSu8BKKsVSTSBfFUGTMh+xEPCjuYNHndh4By/7yG6w/oi/57hgwooAobgtwB/al
        XH+T795Oz0T7Cge8qUZ2gcRBYXPTXmCX8d3xDtATZMiljLV6RgMpGrrSWeRyrw==
Date:   Mon, 11 Dec 2023 11:34:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nvmem tree
Message-ID: <20231211113419.327947a7@xps-13>
In-Reply-To: <20231211084841.11b2ee48@canb.auug.org.au>
References: <20231211084841.11b2ee48@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

sfr@canb.auug.org.au wrote on Mon, 11 Dec 2023 08:48:41 +1100:

> Hi all,
>=20
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>=20
>   05349b48e254 ("nvmem: Do not expect fixed layouts to grab a layout driv=
er")
>=20
> This is commit
>=20
>   b7c1e53751cb ("nvmem: Do not expect fixed layouts to grab a layout driv=
er")
>=20
> in Linus' tree.
>=20
> Also, please keep all the commit message tags together at the end of
> the commit message.
>=20

This is actually fine, Srinivas needs this fix in his tree for
applying other patches, but he anyway sends a big "series" to GKH at
-rc6 who finally applies the content of the nvmem-next branch.

Thanks for the reports,
Miqu=C3=A8l

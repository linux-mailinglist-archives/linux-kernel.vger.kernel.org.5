Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9957E75E491
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGWTlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWTlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:41:17 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE6A8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:41:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 340905C0063;
        Sun, 23 Jul 2023 15:41:11 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Sun, 23 Jul 2023 15:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1690141271; x=
        1690227671; bh=0W5XwGXuOpwCRV6H16V7wLiCytnuII5cpJCFDXkenzI=; b=T
        lNqK87Lcr/HEQyfjQR/59cn5tygIjnf44ijZ1P6x8bLdlDl8zU0b0jekVKN3p7dk
        KPG8DNGLW43clZ2ElqmqvP1qd8mBQUZA0kKbluALCnVhl2Uy/eo1ByAwg1Py1xAX
        O96HjEFrrIYO6cXNgyVI507jb/5lXeGOtMCpGsDd5cAlV92ePsRJjyq8MeyT77td
        TANfgXbJ6+mzlVXTR2ugqWlfgXqK6yONFjMaXnWUX8sER2O9ldh61JIIi1ox3Ab6
        Gn0LENBCmt9t3mU6xgwbtXktnyDcpZFn9IVuL9G/wB+CPnBqdu6aqDSkdPxuDNcC
        w3ofypSZlq6z9xgwi3ncQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690141271; x=1690227671; bh=0W5XwGXuOpwCR
        V6H16V7wLiCytnuII5cpJCFDXkenzI=; b=iK0Ts7lO+sq6PijKny7XGPnnzLPIc
        Z3H/U+sBY8uAt/Woa55GPa5ZMsUGPQdDd8xhJJiMZIdh+I0m6OEPr3wl8McAUxDA
        hNhBhsI3QwaaICwbSwFhuTbYk/WsLPCXe5L6sL8qepOJHsCV/tHkSQUC3BK+hvPv
        jF6wlmgFgOIom2abrF4t0e9p1NbjwWesJnYeuMDB/Kd9I+s+0XZah+zVukplO3Q1
        67ucDJTV97vnzyRVS2kM6IzDqBvSFVGLa4b1E3MPVBAHF5y1P4xPZ4IUITFrEFhF
        bNBF7YA7JcApnVl1mi9SzySTUbfi0wdnrZ2OCxbmoaCWsYXDUQXP4+imQ==
X-ME-Sender: <xms:VoK9ZAwFgtIWaVTEsTnXQxIyLX9SeGYii1pua4lbhZ-HtUUel2G7HQ>
    <xme:VoK9ZEQK68jdxzMxHjz168tyLOQ3IYfgpOMz5fcAFgQh9ZaecQ_tMxUnkzoHLHUtc
    6gnhUczk1pE9HLeKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheeigddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfho
    hhhnucfvhhhomhhsohhnfdcuoehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsth
    hmrghilhdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeejjeefieelgfeftdekkeef
    keffgeelteelhfehkeelgefgtddtveevudehteetgfenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheplhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:VoK9ZCXPXB2ualRwmLQhcczYvy3pm4DP30Zkcjif1ERwGSUsq5tDOQ>
    <xmx:VoK9ZOjcnjMWfGctz5Xa5uw8q7qmItn51GCEHr7BJc0mrlXzNXXwiw>
    <xmx:VoK9ZCBDQMeeH5FAtASE5zRupL9VmQrhPc2Vc0ZSrt2que7S4SiQAA>
    <xmx:V4K9ZE3F6uunNjJdi_yN67Bf6T3cD6cANPf6ouCZcK6whHZIpGFVvg>
Feedback-ID: ia7894244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A3BA2A20085; Sun, 23 Jul 2023 15:41:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <925d1b35-3e70-4b5d-9533-f730a652d242@app.fastmail.com>
In-Reply-To: <20230717075147.43326-2-miquel.raynal@bootlin.com>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
 <20230717075147.43326-2-miquel.raynal@bootlin.com>
Date:   Sun, 23 Jul 2023 19:39:50 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Robert Marko" <robert.marko@sartura.hr>,
        "Luka Perkov" <luka.perkov@sartura.hr>,
        "Michael Walle" <michael@walle.cc>,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: [PATCH v6 1/3] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Content-Type: text/plain
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Mon, 17 Jul 2023, at 07:51, Miquel Raynal wrote:
> The binary content of nvmem devices is available to the user so in the
> easiest cases, finding the content of a cell is rather easy as it is
> just a matter of looking at a known and fixed offset. However, nvmem
> layouts have been recently introduced to cope with more advanced
> situations, where the offset and size of the cells is not known in
> advance or is dynamic. When using layouts, more advanced parsers are
> used by the kernel in order to give direct access to the content of each
> cell regardless of their position/size in the underlying device, but
> these information were not accessible to the user.
>
> By exposing the nvmem cells to the user through a dedicated cell/ folder
> containing one file per cell, we provide a straightforward access to
> useful user information without the need for re-writing a userland
> parser. Content of nvmem cells is usually: product names, manufacturing
> date, MAC addresses, etc,
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/ABI/testing/sysfs-nvmem-cells | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
>
> diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells 
> b/Documentation/ABI/testing/sysfs-nvmem-cells
> new file mode 100644
> index 000000000000..b2d15a8d36e5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
> @@ -0,0 +1,19 @@
> +What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
> +Date:		May 2023
> +KernelVersion:	6.5
> +Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
> +Description:
> +		The "cells" folder contains one file per cell exposed by
> +		the nvmem device. The name of the file is the cell name.

Could we consider using a file within a folder (name defined by cell propertys) to access the cell bytes?
Example (pick the best path and filename):
/sys/bus/nvmem/devices/.../cells/<cell-name>/bytes

That way, it is much easier to expand this at a later stage,
like adding an of_node link at
/sys/bus/nvmem/devices/.../cells/<cell-name>/of_node
or exposing other nvmem cell properties.

This is particularly relevant given the cell-name alone does not always
uniquely represent a cell on an nvmem device.
https://lore.kernel.org/lkml/ZLaZ7fzUSsa0Igx1@makrotopia.org/
https://lore.kernel.org/lkml/e7173ab2-d3b2-4f75-beb8-32593b868774@www.fastmail.com/

> +		The length of the file is the size of the cell (when
> +		known). The content of the file is the binary content of
> +		the cell (may sometimes be ASCII, likely without
> +		trailing character).
> +		Note: This file is only present if CONFIG_NVMEM_SYSFS
> +		is enabled.
> +
> +		Example::
> +
> +		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name
> +		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
> +		  0000000a
> -- 
> 2.34.1

Cheers,

-- 
  John Thomson

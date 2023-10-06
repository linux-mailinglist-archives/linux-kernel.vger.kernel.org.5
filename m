Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72A17BB6EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjJFLtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjJFLs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:48:59 -0400
Received: from 10.mo575.mail-out.ovh.net (10.mo575.mail-out.ovh.net [46.105.79.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75071CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:48:57 -0700 (PDT)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.146.20])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id A61CC2A376
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:41:54 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-9dvr6 (unknown [10.110.115.40])
        by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 895271FE57;
        Fri,  6 Oct 2023 11:41:52 +0000 (UTC)
Received: from RCM-web7.webmail.mail.ovh.net ([151.80.29.19])
        by ghost-submission-6684bf9d7b-9dvr6 with ESMTPSA
        id oZtWH4DyH2Xt2T8A6QqK6A
        (envelope-from <rafal@milecki.pl>); Fri, 06 Oct 2023 11:41:52 +0000
MIME-Version: 1.0
Date:   Fri, 06 Oct 2023 13:41:52 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v12 2/7] nvmem: Clarify the situation when there is no DT
 node available
In-Reply-To: <20231005155907.2701706-3-miquel.raynal@bootlin.com>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
 <20231005155907.2701706-3-miquel.raynal@bootlin.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <05cd4592d0cfe0fb86aeb24db01de547@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17474529506700995485
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepgffhueeihfeitdettdehfefhieefffevkedvgeetteekteejtdeivddvhffgffffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpudehuddrkedtrddvledrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-05 17:59, Miquel Raynal wrote:
> At a first look it might seem that the presence of the of_node pointer
> in the nvmem device does not matter much, but in practice, after 
> looking
> deep into the DT core, nvmem_add_cells_from_dt() will simply and always
> return NULL if this field is not provided. As most mtd devices don't
> populate this field (this could evolve later), it means none of their
> children cells will be populated unless no_of_node is explicitly set to
> false. In order to clarify the logic, let's add clear check at the
> beginning of this helper.

I'm somehow confused by above explanation and code too. I read it
carefully 5 times but I can't see what exactly this change helps with.

At first look at nvmem_add_cells_from_legacy_of() I can see it uses
"of_node" so I don't really agree with "it might seem that the presence
of the of_node pointer in the nvmem device does not matter much".

You really don't need to look deep into DT core (actually you don't have
to look into it at all) to understand that nvmem_add_cells_from_dt()
will return 0 (nitpicking: not NULL) for a NULL pointer. It's all made
of for_each_child_of_node(). Obviously it does nothing if there is
nothing to loop over.

Given that for_each_child_of_node() is NULL-safe I think code from this
patch is redundant.

Later you mention "no_of_node" which I agree to be a very non-intuitive
config option. As pointed in another thread I already sent:
[PATCH] Revert "nvmem: add new config option"
https://lore.kernel.org/lkml/ba3c419a-6511-480a-b5f2-6c418f9c02e7@gmail.com/t/

Maybe with above patch finally things will get more clear and we don't
need this PATCH after all?


> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/nvmem/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index eaf6a3fe8ca6..286efd3f5a31 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -743,6 +743,9 @@ static int nvmem_add_cells_from_dt(struct
> nvmem_device *nvmem, struct device_nod
> 
>  static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
>  {
> +	if (!nvmem->dev.of_node)
> +		return 0;
> +
>  	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
>  }

-- 
Rafał Miłecki

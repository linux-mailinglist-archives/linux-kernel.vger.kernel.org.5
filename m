Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3327BA210
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjJEPMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjJEPLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:11:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0F88E93;
        Thu,  5 Oct 2023 07:42:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E053EC116B0;
        Thu,  5 Oct 2023 08:46:13 +0000 (UTC)
Message-ID: <ef1d5a63-6a83-46fc-b593-2d507a1ce097@xs4all.nl>
Date:   Thu, 5 Oct 2023 10:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: mediatek: vcodec: Fix encoder access NULL
 pointer
Content-Language: en-US, nl
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     Irui Wang <irui.wang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Maoguang Meng <maoguang.meng@mediatek.com>
References: <20230926101909.15030-1-irui.wang@mediatek.com>
 <36356e37-9abd-4dec-a716-9822b67bd0fa@xs4all.nl>
 <54962983-fa23-4ecc-9874-f59a1387cf70@xs4all.nl>
In-Reply-To: <54962983-fa23-4ecc-9874-f59a1387cf70@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 08:54, Hans Verkuil wrote:
> Ping! Is this a fix for 6.6 or not?
> 
> Regards,
> 
> 	Hans
> 
> On 02/10/2023 12:24, Hans Verkuil wrote:
>> On 26/09/2023 12:19, Irui Wang wrote:
>>> Need to set the private data with encoder device, or will access
>>> NULL pointer in encoder handler.
>>>
>>> Fixes: 1972e32431ed ("media: mediatek: vcodec: Fix possible invalid memory access for encoder")
>>>
>>> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
>>> ---
>>>  drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
>>> index d299cc2962a5..ae6290d28f8e 100644
>>> --- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
>>> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
>>> @@ -138,7 +138,8 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
>>>  	vpu->ctx->vpu_inst = vpu;
>>>  
>>>  	status = mtk_vcodec_fw_ipi_register(vpu->ctx->dev->fw_handler, vpu->id,
>>> -					    vpu_enc_ipi_handler, "venc", NULL);
>>> +					    vpu_enc_ipi_handler, "venc",
>>> +					    vpu->ctx->dev);
>>>  
>>>  	if (status) {
>>>  		mtk_venc_err(vpu->ctx, "vpu_ipi_register fail %d", status);
>>
>> Is this a fix that should go to 6.6?

This looks like a real bug, so I'll queue this up for 6.6.

Regards,

	Hans

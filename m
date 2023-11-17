Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9477EEDAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjKQIoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjKQIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:44:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6411F;
        Fri, 17 Nov 2023 00:44:20 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 723766607383;
        Fri, 17 Nov 2023 08:44:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700210659;
        bh=7oMl9w52a+QB6ng2YsEmlurqeNPbyrAq7NcFSX0AaGg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=blqnPVJVM1ijAH1uLvVQcHlzHxsHtMNYmWcqpT4FYUVTCMhB+8mQ7aSTo/s6hwU9y
         +W9ySZMfe9yjZ180w1K6qeUc745ZefIqs82y166DEAnurQNlUQ/UHh59ROEd0nud2L
         0RsNbbhSk45lqbEQdI0EQ53sIrrPLXQHVjiox+XjdTbmWoDnfvRXzo3khK9Drjb5++
         Oscg/TfaSknQavekv3bl01hR3PQVgxYshQgll9ykmFItRbGvt7PQDwkaZ00N59biZv
         neoMSaReFr5HhpbRP4g+WwT8prAmQVYQCO5AlRW3fXOBfpzbinncMuK3L980tOaPRV
         H6sSEgOiJiZzA==
Message-ID: <0b16a22f-9d23-41d4-a106-a5a20b3f52c5@collabora.com>
Date:   Fri, 17 Nov 2023 09:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/6] media: verisilicon: Improve constant's name
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com
References: <20231116154816.70959-1-andrzej.p@collabora.com>
 <20231116154816.70959-4-andrzej.p@collabora.com>
 <CAGXv+5GhaF94ZRwrZ_CWg3j6bVYyEqZru9LM7ABDB29-cPhqSQ@mail.gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <CAGXv+5GhaF94ZRwrZ_CWg3j6bVYyEqZru9LM7ABDB29-cPhqSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for looking at it.

W dniu 17.11.2023 o 07:11, Chen-Yu Tsai pisze:
> On Thu, Nov 16, 2023 at 11:48 PM Andrzej Pietrasiewicz
> <andrzej.p@collabora.com> wrote:
>>
>> For VP8 BIT(18) of this register is for enabling the boolean encoder.
> 
> Yes, but for H.264 it selects the entropy coding mode, 0 for CAVLC
> and 1 for CABAC. You even add it back in the last patch. I'd do it
> here, so you disambiguate the definition within one patch.
> 

The rationale behind doing what I did is this:

At this moment the H1 H.264 encoder is non-existent in the kernel,
so why would we keep H.264-related definitions? I re-introduce it
when the encoder appears.

That said, other H.264-specific constants do exist at this moment anyway.
So I'm fine with either approach.

Andrzej

> ChenYu
> 
> 
>> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro_h1_regs.h    | 2 +-
>>   drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_h1_regs.h b/drivers/media/platform/verisilicon/hantro_h1_regs.h
>> index 7752d1291c0e..c1c66c934a24 100644
>> --- a/drivers/media/platform/verisilicon/hantro_h1_regs.h
>> +++ b/drivers/media/platform/verisilicon/hantro_h1_regs.h
>> @@ -70,7 +70,7 @@
>>   #define    H1_REG_ENC_CTRL2_DISABLE_QUARTER_PIXMV      BIT(22)
>>   #define    H1_REG_ENC_CTRL2_TRANS8X8_MODE_EN           BIT(21)
>>   #define    H1_REG_ENC_CTRL2_CABAC_INIT_IDC(x)          ((x) << 19)
>> -#define    H1_REG_ENC_CTRL2_ENTROPY_CODING_MODE                BIT(18)
>> +#define    H1_REG_ENC_CTRL2_VP8_BOOLENC_ENABLE         BIT(18)
>>   #define    H1_REG_ENC_CTRL2_H264_INTER4X4_MODE         BIT(17)
>>   #define    H1_REG_ENC_CTRL2_H264_STREAM_MODE           BIT(16)
>>   #define    H1_REG_ENC_CTRL2_INTRA16X16_MODE(x)         ((x))
>> diff --git a/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c b/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
>> index 05aa0dd9c09c..08c5079fbfd0 100644
>> --- a/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
>> +++ b/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
>> @@ -1226,7 +1226,7 @@ static void hantro_h1_vp8_enc_set_params(struct hantro_dev *vpu, struct hantro_c
>>          reg = 0;
>>          if (mb_width * mb_height > MAX_MB_COUNT_TO_DISABLE_QUARTER_PIXEL_MV)
>>                  reg = H1_REG_ENC_CTRL2_DISABLE_QUARTER_PIXMV;
>> -       reg |= H1_REG_ENC_CTRL2_ENTROPY_CODING_MODE;
>> +       reg |= H1_REG_ENC_CTRL2_VP8_BOOLENC_ENABLE;
>>
>>          inter_favor = 128 - ctx->vp8_enc.prob_intra;
>>          if (inter_favor >= 0)
>> --
>> 2.25.1
>>
>>
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com


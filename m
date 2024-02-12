Return-Path: <linux-kernel+bounces-61872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAA58517A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20E6B215D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B53C06A;
	Mon, 12 Feb 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VfeWnq9V"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4B3CF57
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750437; cv=none; b=dDkHXx70LlEFSuGwXDkGtPYc8ugB3fCGkOnMUNhsgpiRwJBtIxacXyzodwFiunKKHb/c+4FxAzX0LaegpDmKpE4NO6/LSTgCUoZZ8TsCTLVTld+ZJk+gZBK4Wac++Mge4wMWBFNAxGhsQG+ZvXLo+bpIqv9Rc2xTtQcQOYsRULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750437; c=relaxed/simple;
	bh=iAq0vYG/SsCMrTq7cZmj2bBoP9DrqTRoY+5WZPk8mbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJo18ubjPvERdyBbBoxRMdJYhWbggzJv/d1ud/g1oSESIag3mnOKOecaIrFBfFBaOKPPVa+3ywl6A0EfbrqGwUMsKeusHbWDYy6GgOaV301Pa8QN/QhHf3Kzej+Z4xSNrdv+3l+q90IKKpNR9RhY4M8yXZEurPwlg9RvlQ+rL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VfeWnq9V; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso3492898a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707750432; x=1708355232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC3i7WPMyRp3IYdvEIEGD0i8jh4jq28FmjUJ5nE720E=;
        b=VfeWnq9V5APxjB2kUDhWC0+spQEiY8pGtfgmzvIv+sCdl7sEH0JqoznBA+1NkcAIHs
         V96AdfoJpupkCwMP48iabo9M48VqcQmt+rZvUcMNxWBdkmjCMmAOsPofr1N9hQnLHjsn
         jxPrIGTkvoCIfr7W2VWXvMJsXcZzy1PKhxL2Bq5z/VJBjPpS7m1Z5iu9H2oPfIHGgxWR
         IDbHZLBrJMFpODu3/XFEJM9S+M25ZGHRM9ZM3loAq2TsFN1u6FonGuSEvNy90PADR45A
         TXDHI+M0SWno5wwVerInWn5RqWQnNRifaBGdKAAspGi0DKV+IR3Fra7pNr/7rnt1ea0m
         nqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750432; x=1708355232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC3i7WPMyRp3IYdvEIEGD0i8jh4jq28FmjUJ5nE720E=;
        b=Izn2kqvyD9e/Zxbuhi8/Ygyfw9FME4arnoNP3XUqjykzpY0M4lW1rjAmmtmZpTnbUB
         Gnz5qy+IcP3E8r33c7QKCt+4CnKV8YzNOIpAEtGjVEXl3kGQdK/+k42tQefjCtktlgkr
         Mc77z3KrGplE6wW0tAccaWy49IjvHgmjGUnnfiRPV9GMKhsACgol47Ir9aRvXmJWhwBv
         njtDxsuuBCo8jxFTV3jToqC9m/JPddZquHn+oJ3Jt7EdhNzHQiB4uvZN8+ElIxWGdfOb
         BZKwYoqYN5vcNsG7ujGdc8TOKTb6ukoHh8og+N88O6peH1zqZxgPPSMvea4chQwmltDl
         qIhQ==
X-Gm-Message-State: AOJu0YwakKVoxYWLT3dgOXjOXin8Y4RfM/cb8TdGvfhClriHBNvPDqPQ
	1oQx27LZP2H9PK2AMztgrRndrEOaJLZq/LhtjgcbkigHpLDH9wn8mBv2lPJifGXQKDLWaq0s2MY
	n5QUv04RaM74FCRyrpsBwISf1lOxPVaTe4V903w==
X-Google-Smtp-Source: AGHT+IGOztcD6VUkwD3HWT6e1rn0+70jwBqA/VXoPNP45PWBLZM25XLMCH/NpPo2qWX16wJHIZztxtkKeA3vGhJSmGw=
X-Received: by 2002:aa7:c393:0:b0:55e:ea35:1da4 with SMTP id
 k19-20020aa7c393000000b0055eea351da4mr4872130edq.4.1707750432529; Mon, 12 Feb
 2024 07:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110141443.364655-1-jstephan@baylibre.com>
 <20240110141443.364655-4-jstephan@baylibre.com> <3c2bee40-3792-409c-b42f-f8b013ff641c@collabora.com>
In-Reply-To: <3c2bee40-3792-409c-b42f-f8b013ff641c@collabora.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 12 Feb 2024 16:07:03 +0100
Message-ID: <CAEHHSvaUSJTTQpUD0eX3dFw7rohRm6Z=_RO0Sknn9JxfH603UQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Louis Kuo <louis.kuo@mediatek.com>, Phi-bang Nguyen <pnguyen@baylibre.com>, 
	Florian Sylvestre <fsylvestre@baylibre.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andy Hsieh <andy.hsieh@mediatek.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-media@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Paul Elder <paul.elder@ideasonboard.com>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

Thank you for your comments. Few questions below.

Cheers
Julien

Le jeu. 11 janv. 2024 =C3=A0 13:04, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> a =C3=A9crit :
 .. snip ..
>
> > +             .code =3D MEDIA_BUS_FMT_S5C_UYVY_JPEG_1X8,
> > +             .flags =3D MTK_SENINF_FORMAT_JPEG,
> > +     },
> > +     /* Keep the input-only formats last. */
>
> Your comment doesn't make me understand why input-only formats shall be
> placed last - and makes me think that having two arrays (one for both
> and one for input only) would be easier and less error prone, other than
> making you able to drop the MTK_SENINF_FORMAT_INPUT_ONLY flag entirely.
>

Not sure I agree with you on this... If I want to split into two I
will have to duplicate
the whole mtk_seninf_formats[] which is quite big because the first 26
formats are
for both input and source pad. Moreover it will introduce some check on the=
 pad
before choosing the correct format structure..  or maybe I am missing
your point?

> > +     {
> > +             .code =3D MEDIA_BUS_FMT_SGRBG10_DPCM8_1X8,
> > +             .flags =3D MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INP=
UT_ONLY,
> > +     }, {
> > +             .code =3D MEDIA_BUS_FMT_SRGGB10_DPCM8_1X8,
> > +             .flags =3D MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INP=
UT_ONLY,
> > +     }, {
> > +             .code =3D MEDIA_BUS_FMT_SBGGR10_DPCM8_1X8,
> > +             .flags =3D MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INP=
UT_ONLY,
> > +     }, {
> > +             .code =3D MEDIA_BUS_FMT_SGBRG10_DPCM8_1X8,
> > +             .flags =3D MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INP=
UT_ONLY,
> > +     }
> > +};
> > +
> > +static const struct mtk_seninf_format_info *mtk_seninf_format_info(u32=
 code)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(mtk_seninf_formats); ++i) {
> > +             if (mtk_seninf_formats[i].code =3D=3D code)
> > +                     return &mtk_seninf_formats[i];
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
>
> ..snip..
>
> > +
> > +static void mtk_seninf_input_setup_csi2(struct mtk_seninf_input *input=
,
> > +                                     struct v4l2_subdev_state *state)
> > +{
> > +     const struct mtk_seninf_format_info *fmtinfo;
> > +     const struct v4l2_mbus_framefmt *format;
> > +     unsigned int num_data_lanes =3D input->bus.num_data_lanes;
> > +     unsigned int val =3D 0;
> > +
> > +     format =3D v4l2_subdev_state_get_stream_format(state, input->pad,=
 0);
> > +     fmtinfo =3D mtk_seninf_format_info(format->code);
> > +
> > +     /* Configure timestamp */
> > +     writel(SENINF_TIMESTAMP_STEP, input->base + SENINF_TG1_TM_STP);
> > +
> > +     /* HQ */
> > +     writel(0x0, input->base + SENINF_TG1_PH_CNT);
>
> Zero means:
>   - Sensor master clock: ISP_CLK
>   - Sensor clock polarity: Rising edge
>   - Sensor reset deasserted
>   - Sensor powered up
>   - Pixel clock inversion disabled
>   - Sensor master clock polarity disabled
>   - Phase counter disabled
>
> > +     writel(0x10001, input->base + SENINF_TG1_SEN_CK);
>
> Unroll this one... this is the TG1 sensor clock divider.
>
> CLKFL GENMASK(5, 0)
> CLKRS GENMASK(13, 8)
> CLKCNT GENMASK(21,16)
>
> Like this, I don't get what you're trying to set, because you're using a =
fixed
> sensor clock rate, meaning that only a handful of camera sensors will be =
usable.
>
> Is this 8Mhz? 16? 24? what? :-)
>
> Two hints:
>   - sensor_clk =3D clk_get_rate(isp_clk) / (tg1_sen_ck_clkcnt + 1);
>   - int mtk_seninf_set_sensor_clk(u8 rate_mhz);
>
> Please :-)
>
> > +
> > +     /* First Enable Sensor interface and select pad (0x1a04_0200) */
> > +     mtk_seninf_input_update(input, SENINF_CTRL, SENINF_EN, 1);
> > +     mtk_seninf_input_update(input, SENINF_CTRL, PAD2CAM_DATA_SEL, SEN=
INF_PAD_10BIT);
> > +     mtk_seninf_input_update(input, SENINF_CTRL, SENINF_SRC_SEL, 0);
> > +     mtk_seninf_input_update(input, SENINF_CTRL_EXT, SENINF_CSI2_IP_EN=
, 1);
> > +     mtk_seninf_input_update(input, SENINF_CTRL_EXT, SENINF_NCSI2_IP_E=
N, 0);
> > +
> > +     /* DPCM Enable */
> > +     if (fmtinfo->flags & MTK_SENINF_FORMAT_DPCM)
> > +             val =3D SENINF_CSI2_DPCM_DI_2A_DPCM_EN;
> > +     else
> > +             val =3D SENINF_CSI2_DPCM_DI_30_DPCM_EN;
> > +     writel(val, input->base + SENINF_CSI2_DPCM);
> > +
> > +     /* Settle delay */
> > +     mtk_seninf_input_update(input, SENINF_CSI2_LNRD_TIMING,
> > +                             DATA_SETTLE_PARAMETER, SENINF_SETTLE_DELA=
Y);
> > +
> > +     /* HQ */
> > +     writel(0x10, input->base + SENINF_CSI2_LNRC_FSM);
>
> As far as I know, SENINF_CSI2_LNRC_FSM is a read-only register: this writ=
e will do
> exactly nothing...
>
> > +
> > +     /* CSI2 control */
> > +     val =3D readl(input->base + SENINF_CSI2_CTL)
> > +         | (FIELD_PREP(SENINF_CSI2_CTL_ED_SEL, DATA_HEADER_ORDER_DI_WC=
L_WCH)
> > +         | SENINF_CSI2_CTL_CLOCK_LANE_EN | (BIT(num_data_lanes) - 1));
> > +     writel(val, input->base + SENINF_CSI2_CTL);
> > +
> > +     mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL,
> > +                             BYPASS_LANE_RESYNC, 0);
>
> 93 columns: fits in one line (not only this one!).
>
> > +     mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL, CDPH=
Y_SEL, 0);
> > +     mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL,
> > +                             CPHY_LANE_RESYNC_CNT, 3);
> > +     mtk_seninf_input_update(input, SENINF_CSI2_MODE, CSR_CSI2_MODE, 0=
);
> > +     mtk_seninf_input_update(input, SENINF_CSI2_MODE, CSR_CSI2_HEADER_=
LEN, 0);
> > +     mtk_seninf_input_update(input, SENINF_CSI2_DPHY_SYNC, SYNC_SEQ_MA=
SK_0, 0xff00);
> > +     mtk_seninf_input_update(input, SENINF_CSI2_DPHY_SYNC, SYNC_SEQ_PA=
T_0, 0x001d);
> > +
> > +     mtk_seninf_input_update(input, SENINF_CSI2_CTL, CLOCK_HS_OPTION, =
0);
> > +     mtk_seninf_input_update(input, SENINF_CSI2_CTL, HSRX_DET_EN, 0);
> > +     mtk_seninf_input_update(input, SENINF_CSI2_CTL, HS_TRAIL_EN, 1);
> > +     mtk_seninf_input_update(input, SENINF_CSI2_HS_TRAIL, HS_TRAIL_PAR=
AMETER,
> > +                             SENINF_HS_TRAIL_PARAMETER);
> > +
> > +     /* Set debug port to output packet number */
> > +     mtk_seninf_input_update(input, SENINF_CSI2_DGB_SEL, DEBUG_EN, 1);
> > +     mtk_seninf_input_update(input, SENINF_CSI2_DGB_SEL, DEBUG_SEL, 0x=
1a);
> > +
> > +     /* HQ */
> > +     writel(0xfffffffe, input->base + SENINF_CSI2_SPARE0);
>
> I have no idea what this SPARE0 does, but I think that this is something =
that you
> want to get from platform_data, as I guess this would be different on var=
ious SoCs?
>
> > +
> > +     /* Enable CSI2 IRQ mask */
> > +     /* Turn on all interrupt */
> > +     writel(0xffffffff, input->base + SENINF_CSI2_INT_EN);
> > +     /* Write clear CSI2 IRQ */
> > +     writel(0xffffffff, input->base + SENINF_CSI2_INT_STATUS);
> > +     /* Enable CSI2 Extend IRQ mask */
>
> You missed:
>         writel(0xffffffff, input->base + SENINF_CSI2_INT_EN_EXT);
>
> P.S.: #define SENINF_CSI2_INT_EN_EXT 0x0b10
>
>
> > +     /* Turn on all interrupt */
>
> /* Reset the CSI2 to commit changes */ <-- makes more sense, doesn't it?
>
> > +     mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 1);
> > +     udelay(1);
> > +     mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 0);
> > +}
> > +
> > +static void mtk_seninf_mux_setup(struct mtk_seninf_mux *mux,
> > +                              struct mtk_seninf_input *input,
> > +                              struct v4l2_subdev_state *state)
> > +{
> > +     const struct mtk_seninf_format_info *fmtinfo;
> > +     const struct v4l2_mbus_framefmt *format;
> > +     unsigned int pix_sel_ext;
> > +     unsigned int pix_sel;
> > +     unsigned int hs_pol =3D 0;
> > +     unsigned int vs_pol =3D 0;
> > +     unsigned int val;
> > +     u32 rst_mask;
> > +
> > +     format =3D v4l2_subdev_state_get_stream_format(state, input->pad,=
 0);
> > +     fmtinfo =3D mtk_seninf_format_info(format->code);
> > +
> > +     /* Enable mux */
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_MUX_EN, 1);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_SRC_SEL, SENIN=
F_MIPI_SENSOR);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT, SENINF_SRC_SEL_EX=
T, SENINF_NORMAL_MODEL);
> > +
> > +     pix_sel_ext =3D 0;
> > +     pix_sel =3D 1;
>
>
>         pixels_per_cycle =3D 1;
>         bus_width =3D pixels_per_cycle >> 1;
>
> because:  0 =3D=3D 1pix/cyc, 1 =3D=3D 2pix/cyc, 2 =3D=3D 4pix/cyc, 3 =3D=
=3D 8pix... etc
> ...but the width of this register depends on the SoC, so you also want to=
 set
> constraints to the bus width on a per-soc basis (platform data again, or =
at
> least leave a comment here).>
>         mtk_seninf_mux_update(....  PIX_SEL_EXT, bus_width);
>         mtk_seninf_mux_update(....  PIX_SEL, bus_width);
>

Again, not sure to get your point here. PIX_SEL_EXT and PIX_SEL are 1 bit e=
ach
and according to the datasheet 1pix/cycle is 0 in PIX_SEL_EXT and 0 in PIX_=
SEL,
2 pix/cycles is 0 in PIX_SEL_EXT and 1 in PIX_SEL
and 4 pix/cycle is 1 in PIX_SEL_EXT and 0 in PIX_SEL


> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT, SENINF_PIX_SEL_EX=
T, pix_sel_ext);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_PIX_SEL, pix_s=
el);
> > +
> > +     if (fmtinfo->flags & MTK_SENINF_FORMAT_JPEG) {
> > +             mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_=
EN, 0);
> > +             mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN=
,
> > +                                   FIFO_FLUSH_EN_JPEG_2_PIXEL_MODE);
> > +             mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN,
> > +                             FIFO_PUSH_EN_JPEG_2_PIXEL_MODE);
> > +     } else {
> > +             mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_=
EN, 2);
> > +             mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN=
,
> > +                                  FIFO_FLUSH_EN_NORMAL_MODE);
> > +             mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN,
> > +                             FIFO_PUSH_EN_NORMAL_MODE);
> > +     }
> > +
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_POL, hs_=
pol);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_VSYNC_POL, vs_=
pol);
> > +
> > +     val =3D mtk_seninf_mux_read(mux, SENINF_MUX_CTRL);
> > +     rst_mask =3D SENINF_MUX_CTRL_SENINF_IRQ_SW_RST | SENINF_MUX_CTRL_=
SENINF_MUX_SW_RST;
> > +
> > +     mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val | rst_mask);
>
> Are you sure that you don't need any wait between assertion and deasserti=
on of RST?
> Looks strange, but I don't really know then.
>
> > +     mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val & ~rst_mask);
> > +
> > +     /* HQ */
> > +     mtk_seninf_mux_write(mux, SENINF_MUX_SPARE, 0xc2000);
>
> val =3D SENINF_FIFO_FULL_SEL;
>
> /* SPARE field meaning is unknown */
> val |=3D 0xc0000;
>
>         mtk_seninf_mux_write(mux, SENINF_MUX_SPARE, val);
>
> > +}
> > +
> > +static void mtk_seninf_top_mux_setup(struct mtk_seninf *priv,
> > +                                  enum mtk_seninf_id seninf_id,
> > +                                  struct mtk_seninf_mux *mux)
> > +{
> > +     unsigned int val;
> > +
> > +     /*
> > +      * Use the top mux (from SENINF input to MUX) to configure routin=
g, and
> > +      * hardcode a 1:1 mapping from the MUX instances to the SENINF ou=
tputs.
> > +      */
> > +     val =3D readl(priv->base + SENINF_TOP_MUX_CTRL)
> > +             & ~(0xf << (mux->mux_id * 4));
> > +     val |=3D (seninf_id & 0xf) << (mux->mux_id * 4);
> > +     writel(val, priv->base + SENINF_TOP_MUX_CTRL);
> > +
> > +     writel(0x76541010, priv->base + SENINF_TOP_CAM_MUX_CTRL);
>
> Each four bits of TOP_CAM_MUX_CTRL selects between seninf1 to seninf8 mux=
es, and
> TOP_MUX_CTRL is laid out in the very same way.
>
> This means that if you're calculating a value for TOP_MUX_CTRL, you can d=
o exactly
> the same for TOP_CAM_MUX_CTRL.
>
> > +}
> > +
> > +static void seninf_enable_test_pattern(struct mtk_seninf *priv,
> > +                                    struct v4l2_subdev_state *state)
> > +{
> > +     struct mtk_seninf_input *input =3D &priv->inputs[CSI_PORT_0];
> > +     struct mtk_seninf_mux *mux =3D &priv->muxes[0];
> > +     const struct mtk_seninf_format_info *fmtinfo;
> > +     const struct v4l2_mbus_framefmt *format;
> > +     unsigned int val;
> > +     unsigned int pix_sel_ext;
> > +     unsigned int pix_sel;
> > +     unsigned int hs_pol =3D 0;
> > +     unsigned int vs_pol =3D 0;
> > +     unsigned int seninf =3D 0;
> > +     unsigned int tm_size =3D 0;
> > +     unsigned int mux_id =3D mux->mux_id;
> > +
> > +     format =3D v4l2_subdev_state_get_stream_format(state, priv->conf-=
>nb_inputs, 0);
> > +     fmtinfo =3D mtk_seninf_format_info(format->code);
> > +
> > +     mtk_seninf_update(priv, SENINF_TOP_CTRL, MUX_LP_MODE, 0);
> > +
> > +     mtk_seninf_update(priv, SENINF_TOP_CTRL, SENINF_PCLK_EN, 1);
> > +     mtk_seninf_update(priv, SENINF_TOP_CTRL, SENINF2_PCLK_EN, 1);
> > +
> > +     mtk_seninf_input_update(input, SENINF_CTRL, SENINF_EN, 1);
> > +     mtk_seninf_input_update(input, SENINF_CTRL, SENINF_SRC_SEL, 1);
> > +     mtk_seninf_input_update(input, SENINF_CTRL_EXT,
> > +                             SENINF_TESTMDL_IP_EN, 1);
> > +
> > +     mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_EN, 1);
> > +     mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_PAT, 0xc);
> > +     mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_VSYNC, 4);
> > +     mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_DUMMYPXL, 0x=
28);
> > +
> > +     if (fmtinfo->flags & MTK_SENINF_FORMAT_BAYER)
> > +             mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_FMT,=
 0x0);
> > +     else
> > +             mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_FMT,=
 0x1);
> > +
> > +     tm_size =3D FIELD_PREP(SENINF_TG1_TM_SIZE_TM_LINE, format->height=
 + 8);
> > +     switch (format->code) {
> > +     case MEDIA_BUS_FMT_UYVY8_1X16:
> > +     case MEDIA_BUS_FMT_VYUY8_1X16:
> > +     case MEDIA_BUS_FMT_YUYV8_1X16:
> > +     case MEDIA_BUS_FMT_YVYU8_1X16:
> > +             tm_size |=3D FIELD_PREP(SENINF_TG1_TM_SIZE_TM_PXL, format=
->width * 2);
> > +             break;
> > +     default:
> > +             tm_size |=3D FIELD_PREP(SENINF_TG1_TM_SIZE_TM_PXL, format=
->width);
> > +             break;
> > +     }
> > +     writel(tm_size, input->base + SENINF_TG1_TM_SIZE);
> > +
> > +     writel(TEST_MODEL_CLK_DIVIDED_CNT, input->base + SENINF_TG1_TM_CL=
K);
> > +     writel(TIME_STAMP_DIVIDER, input->base + SENINF_TG1_TM_STP);
> > +
> > +     /* Set top mux */
> > +     val =3D (readl(priv->base + SENINF_TOP_MUX_CTRL) & (~(0xf << (mux=
_id * 4)))) |
> > +             ((seninf & 0xf) << (mux_id * 4));
> > +     writel(val, priv->base + SENINF_TOP_MUX_CTRL);
>
> This is duplicated, and it is the same that you have in mtk_seninf_top_mu=
x_setup()
>
> > +
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_MUX_EN, 1);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
> > +                           SENINF_SRC_SEL_EXT, SENINF_TEST_MODEL);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_SRC_SEL, 1);
> > +
> > +     pix_sel_ext =3D 0;
> > +     pix_sel =3D 1;
> > +
>
> This is in mtk_seninf_mux_setup(), but if you apply my suggestion, it won=
't be in
> there anymore, so you'll call a function here to set the right value :-)
>
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
> > +                           SENINF_PIX_SEL_EXT, pix_sel_ext);
> > +
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_PIX_SEL, pix_s=
el);
> > +
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN, 0x1f);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN, 0x1b);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 2);
> > +
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_POL, hs_=
pol);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_VSYNC_POL, vs_=
pol);
> > +     mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_MASK, 1)=
;
> > +
> > +     mtk_seninf_mux_write(mux, SENINF_MUX_INTEN,
> > +                          SENINF_IRQ_CLR_SEL | SENINF_ALL_ERR_IRQ_EN);
> > +
> > +     mtk_seninf_mux_write(mux, SENINF_MUX_CTRL,
> > +                          mtk_seninf_mux_read(mux, SENINF_MUX_CTRL) |
> > +                          SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> > +                          SENINF_MUX_CTRL_SENINF_MUX_SW_RST);
> > +     udelay(1);
> > +     mtk_seninf_mux_write(mux, SENINF_MUX_CTRL,
> > +                          mtk_seninf_mux_read(mux, SENINF_MUX_CTRL) &
> > +                          ~(SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> > +                            SENINF_MUX_CTRL_SENINF_MUX_SW_RST));
> > +
> > +     //check this
> > +     writel(0x76540010, priv->base + SENINF_TOP_CAM_MUX_CTRL);
> > +
> > +     dev_dbg(priv->dev, "%s: OK\n", __func__);
> > +}
> > +
>
> Cheers,
> Angelo
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFF7D2AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjJWGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJWGnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:43:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3ABDF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:43:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c75ceea588so405836166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698043422; x=1698648222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWXUo8yCgMuDx89RGa0kAK4HpnZZTCnBiMnPnYY2pRQ=;
        b=097ZdUF/XepxXf526TcCEMCYiO38twVGakj+iKGQjRR6siQTuHslmvIxmW2u12Np3J
         A0DzP1ABbhOP+3nWvD5vD7Pz0sDqrUPXBw2pI3TWiweJ31i/1V3qtTiAu4VyoQTAkF1w
         6HeuEPc725W1Ha253NHWzXwLYhY3NMS2lMzleHjduisSiXnaF5z1LHyAhQ11QdlISVtS
         LPSrY0DNoMZ/4tXVCsVwOArRqiclYLlD48MPkS8kqR8BTqN6zrH2+a0VAjN5znzBDcd3
         cQ4R8KJMj4WIuxBDMEOqYJReCvswPK0PM4FqqpfzyX1Cp4FReZNXwsOnafcvGC8gppur
         WtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043422; x=1698648222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWXUo8yCgMuDx89RGa0kAK4HpnZZTCnBiMnPnYY2pRQ=;
        b=R2JqAujcR+AjSr+RUWzhUmeqL3aA/BSNo68uSTU5VScqR9AMlBF8GKeWwFZLlU1igt
         Y1GHPpUy2x28Nof94pKIbJfmPfAEvAalyuMq4HD0Zu/1FTI35Pt/Vt+TEx9ThfqLje9X
         AxTTAp7YPJk/CsHod5T3MiSIIMqNNJN0Uuoe9XAo6Jq+M3CA4la4yeVA6nwGx4JjVKTA
         vhZM5c3huMNS4g1Aup6NsE3sqE59B6zf03aiAM0Ex7cskIeexwHq+I1ircwEJsys4hV3
         YXt+v9WI7rpRx/XUNzHw7P6gUsO41DAcqueViE+6Q+/vfGxMrtyZevDQs8oA5VjHA9wW
         vqWQ==
X-Gm-Message-State: AOJu0YxtgXzJ3yDYQ+ESrDEEwHrH3na9Z//2LumkYCsSAcR9IeTssB0q
        Tlm+B7lvDhCLhQSgjOxuHKgBsg==
X-Google-Smtp-Source: AGHT+IE2xY1XLdZ1hoY/wzt/KAdqJlDerMt0ySpo7bm5amO3+RX0ik8kud4565r/9WcFz81IXd6xhg==
X-Received: by 2002:a17:906:db0a:b0:9bf:270d:8c37 with SMTP id xj10-20020a170906db0a00b009bf270d8c37mr6654997ejb.58.1698043421658;
        Sun, 22 Oct 2023 23:43:41 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:81ba:bcf:e8b4:ca:c434])
        by smtp.gmail.com with ESMTPSA id j12-20020a170906050c00b00977eec7b7e8sm6070287eja.68.2023.10.22.23.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:43:40 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:43:39 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        wenst@chromium.org, amergnat@baylibre.com,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/2] clk: mediatek: clk-mux: Support custom parent
 indices for muxes
Message-ID: <20231023064339.xglriq6ycedjlyd4@blmsp>
References: <20231018103546.48174-1-angelogioacchino.delregno@collabora.com>
 <20231018103546.48174-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018103546.48174-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Wed, Oct 18, 2023 at 12:35:45PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for customized parent indices for MediaTek muxes: this is
> necessary for the case in which we want to exclude some clocks from
> a mux's parent clocks list, where the exclusions are not from the
> very bottom of the list but either in the middle or the beginning.
> 
> Example:
> - MUX1 (all parents)
>   - parent1; idx=0
>   - parent2; idx=1
>   - parent3; idx=2
> 
> - MUX1 (wanted parents)
>   - parent1; idx=0
>   - parent3; idx=2
> 
> To achieve that add a `parent_index` array pointer to struct mtk_mux,
> then in .set_parent(), .get_parent() callbacks check if this array
> was populated and eventually get the index from that.
> 
> Also, to avoid updating all clock drivers for all SoCs, rename the
> "main" macro to __GATE_CLR_SET_UPD_FLAGS (so, `__` was added) and
> add the new member to it; furthermore, GATE_CLK_SET_UPD_FLAGS has
> been reintroduced as being fully compatible with the older version.
> 
> The new parent_index can be specified with the new `_INDEXED`
> variants of the MUX_GATE_CLR_SET_UPD_xxxx macros.
> 
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mux.c | 14 +++++++++++
>  drivers/clk/mediatek/clk-mux.h | 43 ++++++++++++++++++++++++++++++----
>  2 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> index c93bc7f926e5..60990296450b 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -89,6 +89,17 @@ static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
>  	regmap_read(mux->regmap, mux->data->mux_ofs, &val);
>  	val = (val >> mux->data->mux_shift) & mask;
>  
> +	if (mux->data->parent_index) {
> +		int i;
> +
> +		for (i = 0; i < mux->data->num_parents; i++)
> +			if (mux->data->parent_index[i] == val)
> +				return i;
> +
> +		/* Not found: return an impossible index to generate error */
> +		return mux->data->num_parents + 1;
> +	}
> +
>  	return val;
>  }
>  
> @@ -104,6 +115,9 @@ static int mtk_clk_mux_set_parent_setclr_lock(struct clk_hw *hw, u8 index)
>  	else
>  		__acquire(mux->lock);
>  
> +	if (mux->data->parent_index)
> +		index = mux->data->parent_index[index];
> +
>  	regmap_read(mux->regmap, mux->data->mux_ofs, &orig);
>  	val = (orig & ~(mask << mux->data->mux_shift))
>  			| (index << mux->data->mux_shift);
> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> index 7ecb963b0ec6..943ad1d7ce4b 100644
> --- a/drivers/clk/mediatek/clk-mux.h
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -21,6 +21,7 @@ struct mtk_mux {
>  	int id;
>  	const char *name;
>  	const char * const *parent_names;
> +	const u8 *parent_index;
>  	unsigned int flags;

I think at some point it would be nice to have a documentation of these
fields.

>  
>  	u32 mux_ofs;
> @@ -37,9 +38,10 @@ struct mtk_mux {
>  	signed char num_parents;
>  };
>  
> -#define GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,		\
> -			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> -			_gate, _upd_ofs, _upd, _flags, _ops) {		\
> +#define __GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _paridx,		\
> +			 _num_parents, _mux_ofs, _mux_set_ofs,		\
> +			 _mux_clr_ofs, _shift, _width, _gate, _upd_ofs,	\
> +			 _upd, _flags, _ops) {				\
>  		.id = _id,						\
>  		.name = _name,						\
>  		.mux_ofs = _mux_ofs,					\
> @@ -51,11 +53,28 @@ struct mtk_mux {
>  		.gate_shift = _gate,					\
>  		.upd_shift = _upd,					\
>  		.parent_names = _parents,				\
> -		.num_parents = ARRAY_SIZE(_parents),			\
> +		.parent_index = _paridx,				\
> +		.num_parents = _num_parents,				\

I was wondering why you moved the ARRAY_SIZE() to the outer macros and
add another argument to the already huge list of arguments? I couldn't
find a use-case for this in the patches you sent.

Best,
Markus

>  		.flags = _flags,					\
>  		.ops = &_ops,						\
>  	}
>  
> +#define GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,		\
> +			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> +			_gate, _upd_ofs, _upd, _flags, _ops)		\
> +		__GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents,		\
> +			NULL, ARRAY_SIZE(_parents), _mux_ofs,		\
> +			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> +			_gate, _upd_ofs, _upd, _flags, _ops)		\
> +
> +#define GATE_CLR_SET_UPD_FLAGS_INDEXED(_id, _name, _parents, _paridx,	\
> +			 _mux_ofs, _mux_set_ofs, _mux_clr_ofs, _shift,	\
> +			 _width, _gate, _upd_ofs, _upd, _flags, _ops)	\
> +		__GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents,		\
> +			_paridx, ARRAY_SIZE(_paridx), _mux_ofs,		\
> +			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> +			_gate, _upd_ofs, _upd, _flags, _ops)		\
> +
>  extern const struct clk_ops mtk_mux_clr_set_upd_ops;
>  extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
>  
> @@ -67,6 +86,14 @@ extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
>  			_gate, _upd_ofs, _upd, _flags,			\
>  			mtk_mux_gate_clr_set_upd_ops)
>  
> +#define MUX_GATE_CLR_SET_UPD_FLAGS_INDEXED(_id, _name, _parents,	\
> +			_paridx, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,	\
> +			_shift, _width, _gate, _upd_ofs, _upd, _flags)	\
> +		GATE_CLR_SET_UPD_FLAGS_INDEXED(_id, _name, _parents,	\
> +			_paridx, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,	\
> +			_shift, _width, _gate, _upd_ofs, _upd, _flags,	\
> +			mtk_mux_gate_clr_set_upd_ops)
> +
>  #define MUX_GATE_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,		\
>  			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
>  			_gate, _upd_ofs, _upd)				\
> @@ -75,6 +102,14 @@ extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
>  			_width, _gate, _upd_ofs, _upd,			\
>  			CLK_SET_RATE_PARENT)
>  
> +#define MUX_GATE_CLR_SET_UPD_INDEXED(_id, _name, _parents, _paridx,	\
> +			_mux_ofs, _mux_set_ofs, _mux_clr_ofs, _shift,	\
> +			_width, _gate, _upd_ofs, _upd)			\
> +		MUX_GATE_CLR_SET_UPD_FLAGS_INDEXED(_id, _name,		\
> +			_parents, _paridx, _mux_ofs, _mux_set_ofs,	\
> +			_mux_clr_ofs, _shift, _width, _gate, _upd_ofs,	\
> +			_upd, CLK_SET_RATE_PARENT)
> +
>  #define MUX_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,			\
>  			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
>  			_upd_ofs, _upd)					\
> -- 
> 2.42.0
> 

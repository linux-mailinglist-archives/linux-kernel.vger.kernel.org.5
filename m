Return-Path: <linux-kernel+bounces-55229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F8D84B95F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403601C216C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5B1369A0;
	Tue,  6 Feb 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uW8+20f0"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4BA133294
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232817; cv=none; b=nA23ek7mfmUG6A3wLovqN/5IRsh4DKaWN4yQ8DK425GoJ2Ui95ezs062qIYMvKKM55iwnovMlAdaNql8CHgsohzjge7tdmHn0G0TvesbNFGMDwiqSNZi7e93dTDEz11XXnryCdv+a1xUK+jWruzFA7k1WVID/yfEx1oInWq70xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232817; c=relaxed/simple;
	bh=m4e4+ZwBk1L6YM+gk8tAGI0ktRGf/YJ9XTDt7puMoNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFUUvH6WQes7y1lOpgUzQqGqOvg+5RyCMdxFfctk+oi/C9DIvxguw6aU/9Jn+RlqR5LHcIXHnaRIKFVMl5e1MVZc+Yv7+kJzB29WSd/gUhlHibXOQ1okz2F9Z46uoAulpFku18aCypgsIdFhH+qfE5wk1jgaezbjcKnZ1zTqmGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uW8+20f0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d066b532f0so13136441fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707232812; x=1707837612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8O4/FEfA+7IjxF8Rp85VBJ4sBehSYPl7j+rejDvNsk4=;
        b=uW8+20f0zk0Gfy7RSsRJQC8BWcO6Q2KLqIkErNOtC8iCp9rGYjxbAvGmQVravv53dL
         zL4pLQpuaKwlHndCryhZNRKp6ZBTuPw4dOB7tHYLNpB+wZYeRQ4S1ht8ovDc2IFcSDHX
         obSSUbwxghlwDAUd0EWoJIEukAjl76PncBg66Q9Tdd6EvCWbt0FzDTGGnVG40iyAk1pn
         8Fcfp005CU5aek6xfOrja0+NCpUHeAS0IN2U/J3KkGNVhCSGkHbAUxm5X/iTCpHIoS0s
         58/LMY1cGfNBKM8Mki32An4UymY7qdQpQprJjxETOokOnqOP4KUPyTO3rtqK30C67eIC
         TI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232812; x=1707837612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8O4/FEfA+7IjxF8Rp85VBJ4sBehSYPl7j+rejDvNsk4=;
        b=Ti1hjq2V+ff5L/o4KdzdbJ7vp3fynqP7jqVGbglBQeAYPBDj0tSsZzWpFGFgjxBvjO
         XhcO/6phEzHcOvHKBozrERIjDGdR1Ltkv+C3POVLGAxAmdXbio9wgnvq+fNIigLGZPLJ
         Pk+LtYhk6JoMKwKg33dj7ditFNgH5wgP7uj10hcaw9pP2HZH5tdJijmofG92SilUg4CO
         NcPs6HmITh0HHOc9itkzwQhR56De/PCKhHAhFWXNrCeiD1VNSwgP8hY17tSQP4lPtq42
         j4lEHHXueBgX71Phc2U5SAyw1H2x3WxWeLzF0yiRuiMQSw/joyKbyuuooJDcmixjvl6P
         1o1g==
X-Gm-Message-State: AOJu0YwK+XNSWhYORLryTWibfpF3NcXJV0YIp44+n5qcTNL9uf9UXdTH
	3GNlNpwxGX9yHKmtaPN0yrCJjATubRJxkQ6T0emy4g+Yiozr8eOMe09u2FG7rtk=
X-Google-Smtp-Source: AGHT+IHVu9iBrdkkkgq+oanSyuWk5pt0e4V58k5SlYTmULii3Sdu3Gp9l3tagiGY3Gjuxx1SlBhGgg==
X-Received: by 2002:a2e:9958:0:b0:2d0:a8f6:c882 with SMTP id r24-20020a2e9958000000b002d0a8f6c882mr2456827ljj.42.1707232812015;
        Tue, 06 Feb 2024 07:20:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwLA653clU15DlK9NIMq4RaBjxjUy1wiuWtski4FAmOO5NGL5Abxxx/EJ2Vr/tEQDYz6FZ1d7pn+XYl8AAHsPwD0n8P7EoIlK2DQywsZmf3vFJ8Upybe5Y4PzWdGi4cd9RICB3horY4KcRap21y0g5Hjmlnj5yw5CUdG9rff2rbgwzzeaDyVg1c9tDWrQeAXpJGw038Yybu+534ZRjUGwC17W2fJDMqUt+yLWyf0HxLR4YVjG7pw29ebFRAnyzS3n/yhz+xuqaRGJx3q8WQEocmyGmbp+eSbxxE/OnOkoIPkKeq1H04NjblKqBgQtEhu+EwM2EwvQrA/Rz/481UY6puAx5CRVQLzhKkRKTBc4FxXedcItqpw2DZivFCJfbpvfrgfLc8Dtb57L0CCZnntFaJUrGnlNjHGivPQ==
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p8-20020a056402074800b0056022d78141sm1124432edy.56.2024.02.06.07.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:20:11 -0800 (PST)
Message-ID: <16bc6402-c60a-4857-a7e9-a60c3507c979@baylibre.com>
Date: Tue, 6 Feb 2024 16:20:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] drm/mediatek: dsi: Simplify with dev_err_probe and
 remove gotos
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-8-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240206120748.136610-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
> Most of the functions that are called in the probe callback are
> devm managed, or all but mipi_dsi_host_register(): simplify the probe
> function's error paths with dev_err_probe() and remove the lonely
> instance of `goto err_unregister_host` by just directly calling the
> mipi_dsi_host_unregister() function in the devm_request_irq() error
> path, allowing to also remove the same label.

-- 
Regards,
Alexandre


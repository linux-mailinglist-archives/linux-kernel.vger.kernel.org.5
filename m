Return-Path: <linux-kernel+bounces-105020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F587D7B8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AEC282DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB191847;
	Sat, 16 Mar 2024 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="B9KRYPal"
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net [188.40.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7817E9;
	Sat, 16 Mar 2024 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550880; cv=none; b=B9BfLVGzRcW5DFm3P2iMBQicjRbf+/q3i6t3MHL1ryZe+I2mAn5VzAlACX2FlmYYxpituNTTL8epAhvPy1V6aS9TQAVTQfRFs1lzC2/F6TmcMSYD9tMJ63/iut0yd5VJKaQdQTeN5LkPZmxMO0NN4qTOeV0DkMvOIOK/xVrpAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550880; c=relaxed/simple;
	bh=V2cbMG84FkuEYVM7HBqXU9ZfsSSMoMl8L/zJySBXPzI=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=WLzRwtOas3Iz2Vl5MEru2R+QuWgNGWXscKS4miNJufICNKrXNi6/GKmEV2bGqDm2TmSs/DRZWYwE4+ZMJm2Ws1fP3XboZNF/U83RlqiVk9wnxDQ8lD5EPSdDdlwvPE2GeOlJysnPx76eDoru9nK4mJiELeaXTiL/qk1SJXvf5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=B9KRYPal; arc=none smtp.client-ip=188.40.0.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=ywQ9y+5oKaPhhaFqw2qkzCGWxrOovSlD0j98Dksl0Zg=; b=B9KRYPallecwRs
	2aRl5EYW5m0hb1RnyrXRhJU7kMf8uATAu52iSexOSHhmRLEgB2oBe8OhgZuW0kgPvRZ2pA+Zzheny
	eyGDm/qIMlFgUfnbvpcC1Ka53BGiXpo4Hrpr10BYzCvZxiZ5Vci4EbFg20kh2NrZuHSAQKwlXZ30S
	VGw1DhF3Mh+YSY/npUTM8qkddGda6iP1PAAbdLqdy0b1bxD4CRCit+cHMEGdS/+4Z+nVC5nHyxj1g
	L+rkeliGY9QIENslm7E7wcHMef9jRQxNNKOqlxI2uuEQfplGva66NEMizw9I80XND1UkoB6yR2GF6
	8Zc7GHJXlFjzX08oQtpg==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlIQ5-0056kr-Ue; Sat, 16 Mar 2024 03:01:08 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlIQ2-0008Tk-9f; Sat, 16 Mar 2024 03:01:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 16 Mar 2024 03:01:02 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Mark Brown <broonie@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mt7621: allow GPIO chip select lines
In-Reply-To: <20240316005917.20526-1-justin.swartz@risingedge.co.za>
References: <20240316005917.20526-1-justin.swartz@risingedge.co.za>
Message-ID: <182aa3a1fcd05a2e25b55442f58ced5b@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00378959303876)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8iskgoZA/eHMsMNES6KpM7PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIss2oH4Yjh6Q4paNNh70vrmKlRYN8+ZW0XX0AH/7tz8lOUWMR
 3Oz/N19DDfqg//ykQCB4rUl3suKct8rEwEjtlBjGf82vsPPH4Z6bBeyJ2ioKLll7c1zqbZ0Shnfk
 f76m6WzjgyOQ30CX3jGye0AgO43dPg2t4siixN3H6ipUQpvXvESTdFZXVtJe4mr/9HS4WmuNA8WT
 ybi1JN85FSnfKaZl5e9CnNR0t//S8nh6vX9JR7tTkgtGxbJXMnaWeORi/IOL8hFK8UwSRsjj826v
 xIvoo9siXVea4yN8+JzC4p2qtoJeAaAIM5zNlwLSz7WsN95JeBf7gAS8ng44dEWN5vdXFZsEUcDk
 8TfE1VxuxGc2M4JzCc//R6Wyn0xEa4/gbKRUuwP9TxU53J++//mag2wVXO50BuTihrUiUr+Ne0YD
 3ddZG295JphtZpms9X0aBNANCxNWMmHXUTEMGGbKThOghFKJuzFdJ78lk25pCKnYrhUnk1aI/tYo
 PYfrgLItviC2z3vIzjh1mXBwO7cA3KxDuzsITj9XSEsqBTpMNClkAdhK23InA2zzja5I1riDVsRE
 /qfh3BpRIL035Lwa3AR5iWi4B3c2TvD1mYFCey4YQsgkfE0ewNgNUY5lZOQ5d86hkdfWpdNtlHKD
 /N5YI0ii+HGJbtyrZfX5fEH4LjZJ4azDVvtI4xLpBrhpV1Z2g0cC96lvLg9F6alXVA5GCKQ8jPBS
 b1sSQu/sXnVb6BSNV2grY3nM2KxvQC7Qhpxf6rvoiNXJb46OVl4ko+oHyP3Fs7AeUg8cSzkuHTCW
 7WeivJsOGdLHT5AmY9PDPjGy0z6bhalFEM/pjPCQA+BAlnIZxFSV0ux1niV+gnzf0coKruD/dlzX
 C6+t6EZu9kdJL9y/9d1W4+EDLAb1nW3+R45WGZ+IaOzrqhG6HHM1ZKJm4zuNRcgRKiGg7nXFaZTx
 I/6scxhAq/6af00PEtBNjYtqmoKr5eemJzKNdiP7m3gSrWCqyhAo0JR3rThOyxKFbWMT2xK3KT9R
 mx5HiKCYjt40eTXlWiUAYdLmsJdAoPIA+QBBCmRnfEQkXp5mAyXTIBVUuAX2KYddQlACXnsZ2u9C
 nazM3+ZE40UYhpZLE/UxL7hrJSk60SF3F6RYOYr2
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Please ignore this patch. It was accidentally sent without
"v2" nor --in-reply-to=...


On 2024-03-16 02:59, Justin Swartz wrote:
> Extract a magic number, from mt7621_spi_probe(), used to
> declare the number of chip select lines (which co-incides
> with the native chip select count of 2) to a macro.
> 
> Use the newly defined MT7621_NATIVE_CS_COUNT macro to
> instead populate both the spi_controller's max_native_cs
> and num_chipselect members.
> 
> Declare that the spi_controller should use_gpio_descriptors
> if present in the device properties (such as those declared
> in the cs-gpio property of a "ralink,mt7621-spi" compatible
> device-tree node) so that the SPI core will recalculcate
> num_chipselect to account for the GPIO descriptors that
> it should have populated in the cs_gpiod array member.
> 
> Remove the assignment of mt7621_spi_transfer_one_message()
> to the spi_controller's transfer_one_message hook.
> 
> Refactor the mt7621_spi_transfer_one_message() logic into
> mt7621_spi_prepare_message() and mt7621_spi_transfer_one()
> and assign both to the spi_controller's prepare_message
> and transfer_one hooks respectively.
> 
> Migrate the call mt7621_spi_transfer_one_message() made to
> mt7621_spi_flush() just before chip select deactivation,
> to the end of mt7621_spi_write_half_duplex() to ensure
> that any pending data is shifted out of MOSI before the SPI
> core deactivates the chip select line.
> 
> As chip select activation is now taken care of by the SPI
> core, due to the use of the transfer_one hook instead of
> transfer_one_message, the calls to mt7621_spi_set_cs()
> from mt7621_spi_transfer_one_message() have fallen away.
> 
> And although the SPI core will handle activation for GPIO
> chip select lines behind the scenes, it requires a callback
> to allow the driver to perform controller-specific
> operations to control its native chip select lines.
> 
> Rename mt7621_spi_set_cs() to mt7621_spi_set_native_cs()
> and make sure that it takes into account the activation
> polarity of the chip select line it's acting upon, as the
> passed enable parameter represents the desired line level
> and not the desired activation state, and then assign
> mt7621_set_cs() to the spi_controller's set_cs hook.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
> 
> Changes from v1 to v2:
> 
>   Mark Brown recommended using the transfer_one hook
>   approach, so I did.
> 
> 
>  drivers/spi/spi-mt7621.c | 95 +++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
> index 4e9053d03..3770b8e09 100644
> --- a/drivers/spi/spi-mt7621.c
> +++ b/drivers/spi/spi-mt7621.c
> @@ -52,6 +52,8 @@
>  #define MT7621_CPOL		BIT(4)
>  #define MT7621_LSB_FIRST	BIT(3)
> 
> +#define MT7621_NATIVE_CS_COUNT	2
> +
>  struct mt7621_spi {
>  	struct spi_controller	*host;
>  	void __iomem		*base;
> @@ -75,10 +77,11 @@ static inline void mt7621_spi_write(struct
> mt7621_spi *rs, u32 reg, u32 val)
>  	iowrite32(val, rs->base + reg);
>  }
> 
> -static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
> +static void mt7621_spi_set_native_cs(struct spi_device *spi, bool 
> enable)
>  {
>  	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
>  	int cs = spi_get_chipselect(spi, 0);
> +	bool active = spi->mode & SPI_CS_HIGH ? enable : !enable;
>  	u32 polar = 0;
>  	u32 host;
> 
> @@ -94,7 +97,7 @@ static void mt7621_spi_set_cs(struct spi_device
> *spi, int enable)
> 
>  	rs->pending_write = 0;
> 
> -	if (enable)
> +	if (active)
>  		polar = BIT(cs);
>  	mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
>  }
> @@ -154,6 +157,23 @@ static inline int
> mt7621_spi_wait_till_ready(struct mt7621_spi *rs)
>  	return -ETIMEDOUT;
>  }
> 
> +static int mt7621_spi_prepare_message(struct spi_controller *host,
> +				      struct spi_message *m)
> +{
> +	struct mt7621_spi *rs = spi_controller_get_devdata(host);
> +	struct spi_device *spi = m->spi;
> +	unsigned int speed = spi->max_speed_hz;
> +	struct spi_transfer *t = NULL;
> +
> +	mt7621_spi_wait_till_ready(rs);
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list)
> +		if (t->speed_hz < speed)
> +			speed = t->speed_hz;
> +
> +	return mt7621_spi_prepare(spi, speed);
> +}
> +
>  static void mt7621_spi_read_half_duplex(struct mt7621_spi *rs,
>  					int rx_len, u8 *buf)
>  {
> @@ -243,59 +263,30 @@ static void mt7621_spi_write_half_duplex(struct
> mt7621_spi *rs,
>  	}
> 
>  	rs->pending_write = len;
> +	mt7621_spi_flush(rs);
>  }
> 
> -static int mt7621_spi_transfer_one_message(struct spi_controller 
> *host,
> -					   struct spi_message *m)
> +static int mt7621_spi_transfer_one(struct spi_controller *host,
> +				   struct spi_device *spi,
> +				   struct spi_transfer *t)
>  {
>  	struct mt7621_spi *rs = spi_controller_get_devdata(host);
> -	struct spi_device *spi = m->spi;
> -	unsigned int speed = spi->max_speed_hz;
> -	struct spi_transfer *t = NULL;
> -	int status = 0;
> -
> -	mt7621_spi_wait_till_ready(rs);
> 
> -	list_for_each_entry(t, &m->transfers, transfer_list)
> -		if (t->speed_hz < speed)
> -			speed = t->speed_hz;
> -
> -	if (mt7621_spi_prepare(spi, speed)) {
> -		status = -EIO;
> -		goto msg_done;
> -	}
> -
> -	/* Assert CS */
> -	mt7621_spi_set_cs(spi, 1);
> -
> -	m->actual_length = 0;
> -	list_for_each_entry(t, &m->transfers, transfer_list) {
> -		if ((t->rx_buf) && (t->tx_buf)) {
> -			/*
> -			 * This controller will shift some extra data out
> -			 * of spi_opcode if (mosi_bit_cnt > 0) &&
> -			 * (cmd_bit_cnt == 0). So the claimed full-duplex
> -			 * support is broken since we have no way to read
> -			 * the MISO value during that bit.
> -			 */
> -			status = -EIO;
> -			goto msg_done;
> -		} else if (t->rx_buf) {
> -			mt7621_spi_read_half_duplex(rs, t->len, t->rx_buf);
> -		} else if (t->tx_buf) {
> -			mt7621_spi_write_half_duplex(rs, t->len, t->tx_buf);
> -		}
> -		m->actual_length += t->len;
> +	if ((t->rx_buf) && (t->tx_buf)) {
> +		/*
> +		 * This controller will shift some extra data out
> +		 * of spi_opcode if (mosi_bit_cnt > 0) &&
> +		 * (cmd_bit_cnt == 0). So the claimed full-duplex
> +		 * support is broken since we have no way to read
> +		 * the MISO value during that bit.
> +		 */
> +		return -EIO;
> +	} else if (t->rx_buf) {
> +		mt7621_spi_read_half_duplex(rs, t->len, t->rx_buf);
> +	} else if (t->tx_buf) {
> +		mt7621_spi_write_half_duplex(rs, t->len, t->tx_buf);
>  	}
> 
> -	/* Flush data and deassert CS */
> -	mt7621_spi_flush(rs);
> -	mt7621_spi_set_cs(spi, 0);
> -
> -msg_done:
> -	m->status = status;
> -	spi_finalize_current_message(host);
> -
>  	return 0;
>  }
> 
> @@ -353,10 +344,14 @@ static int mt7621_spi_probe(struct 
> platform_device *pdev)
>  	host->mode_bits = SPI_LSB_FIRST;
>  	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
>  	host->setup = mt7621_spi_setup;
> -	host->transfer_one_message = mt7621_spi_transfer_one_message;
> +	host->prepare_message = mt7621_spi_prepare_message;
> +	host->set_cs = mt7621_spi_set_native_cs;
> +	host->transfer_one = mt7621_spi_transfer_one;
>  	host->bits_per_word_mask = SPI_BPW_MASK(8);
>  	host->dev.of_node = pdev->dev.of_node;
> -	host->num_chipselect = 2;
> +	host->max_native_cs = MT7621_NATIVE_CS_COUNT;
> +	host->num_chipselect = MT7621_NATIVE_CS_COUNT;
> +	host->use_gpio_descriptors = true;
> 
>  	dev_set_drvdata(&pdev->dev, host);


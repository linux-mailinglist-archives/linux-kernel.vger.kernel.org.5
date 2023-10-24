Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A057D5A97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjJXSfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbjJXSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:35:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090769F;
        Tue, 24 Oct 2023 11:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698172537; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JOi7zEdl6i/B/DH1FqnymWly4M+XR05uQDqLnykXdPHkigpIY9795qQGNyYPAxVv4m
    AEGwUj3GCwAW9mk7SRcjSAa9nzGLSf/a3Re7Oc5LKQe/eIdj+DLVs5uYZCuU7y0OJobg
    Dzo4QB4Lm/8TNPGAO8LXrLTqElye6zln4RQARNXI7D6yD8lJmywvQii8gRVH0Y+xWBFg
    hMklyhKr9V+T+Tg/FiXKMicOLjUynZpqRHcQjGJUEjyD5d0Irl0GGQb82Ul++bOnegi5
    kssPkscmGV7soRh9g2E8pxvHB9hyLV/ixP7OQOSYPgcJ7BM9KzKz8fwr8QPhfOSCWfiX
    rM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698172537;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ZhyaPj2qq7l4XRxCAh7rMgoC4OVkj1DXYeH9isKDKq4=;
    b=PnhbRX60J+Od0IR7AyQKEd6+gc1lTwpvUqIHE8a3zk/Yu2p7PgngA828Pe9B0HlHMI
    3i20S4xBCFrnMMxwiwfTQdM3UbgozhAvRgxFcnSE9h7APEMANZUounbk9OuKP5zc0TYT
    Jl5T9ccPmO5cAZCyYHPdpo69m6PmkH5aCfwczC9mzOQdjkkH0SgdRiP5+3VIRDZT6DSN
    jQLFMSFeK5sgRrQRiYufpj9nxsYat4Q8B0OOWySZomqudY/iYXHHg26VowV90rZf46/2
    gYFaNs77rq0MvqQe2Q//at4ntItXwifGWRu4hB9yXQlMtDCELVTXFFRiD13780NMRDRE
    gejg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698172537;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ZhyaPj2qq7l4XRxCAh7rMgoC4OVkj1DXYeH9isKDKq4=;
    b=jnmZicsfgfoW0zdQL6YjNmZptR9RhpRzMNpx9OjdHQupgi2Dl/idOSdSNtPrAiNfTp
    UlT0X3iioI3P5Je1wZRmo1dWzPBnq4ls5HrQRZCessY82iHTuGS8mA9tyq/i2XGBvLSM
    nsIf00d1ZLSdSw7vwnZYdym7YLJVv265BouwuYTiNhShvexFcNj1uqSvcghhQUFLiEwu
    1DugMoaXbBvYTtgUpH3htuvm4kcywTXAfEQ8tWmiQngc9U+Gjfr5s/49ShNBOa1xqr8B
    LWgdpWDHfYrp1janE8c8sdKUgsnoyqDMx0MUWBY0b5OV/EA2mF4faR7BUN4Fdzu2txYJ
    zIGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698172537;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ZhyaPj2qq7l4XRxCAh7rMgoC4OVkj1DXYeH9isKDKq4=;
    b=NVJPYMG7OzsRPW776iS1dZlrmLce2AHI/DqDzAXXfDyedbKnFlusvNDZpLxieoN548
    7NRmNgfUYMknVcJYyrBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z+P1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9OIZbRxe
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 24 Oct 2023 20:35:37 +0200 (CEST)
Date:   Tue, 24 Oct 2023 20:35:29 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: Re: [PATCH v2 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZTgOcXMKVY2o_ikx@gerhold.net>
References: <20230930-hx852x-v2-0-c5821947b225@gerhold.net>
 <20230930-hx852x-v2-2-c5821947b225@gerhold.net>
 <ZTVoiklUJaDn5576@nixie71>
 <ZTVuqW7oU5BmPzTS@gerhold.net>
 <ZTcPrC+0K1unNPIv@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTcPrC+0K1unNPIv@nixie71>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Mon, Oct 23, 2023 at 07:28:28PM -0500, Jeff LaBundy wrote:
> On Sun, Oct 22, 2023 at 08:49:13PM +0200, Stephan Gerhold wrote:
> > > > +static int hx852x_read_config(struct hx852x *hx)
> > > > +{
> > > > +	struct device *dev = &hx->client->dev;
> > > > +	struct hx852x_config conf;
> > > > +	int x_res, y_res;
> > > > +	int error;
> > > > +
> > > > +	error = hx852x_power_on(hx);
> > > > +	if (error)
> > > > +		return error;
> > > > +
> > > > +	/* Sensing must be turned on briefly to load the config */
> > > > +	error = hx852x_start(hx);
> > > > +	if (error)
> > > > +		goto err_power_off;
> > > > +
> > > > +	error = hx852x_stop(hx);
> > > > +	if (error)
> > > > +		goto err_power_off;
> > > > +
> > > > +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH,
> > > > +					  HX852X_SRAM_SWITCH_TEST_MODE);
> > > > +	if (error)
> > > > +		goto err_power_off;
> > > > +
> > > > +	error = i2c_smbus_write_word_data(hx->client, HX852X_REG_SRAM_ADDR,
> > > > +					  HX852X_SRAM_ADDR_CONFIG);
> > > > +	if (error)
> > > > +		goto err_test_mode;
> > > > +
> > > > +	error = hx852x_i2c_read(hx, HX852X_REG_FLASH_RPLACE, &conf, sizeof(conf));
> > > > +	if (error)
> > > > +		goto err_test_mode;
> > > > +
> > > > +	x_res = be16_to_cpu(conf.x_res);
> > > > +	y_res = be16_to_cpu(conf.y_res);
> > > > +	hx->max_fingers = (conf.max_pt & 0xf0) >> 4;
> > > > +	dev_dbg(dev, "x res: %u, y res: %u, max fingers: %u\n",
> > > > +		x_res, y_res, hx->max_fingers);
> > > > +
> > > > +	if (hx->max_fingers > HX852X_MAX_FINGERS) {
> > > > +		dev_err(dev, "max supported fingers: %u, found: %u\n",
> > > > +			HX852X_MAX_FINGERS, hx->max_fingers);
> > > > +		error = -EINVAL;
> > > > +		goto err_test_mode;
> > > > +	}
> > > > +
> > > > +	if (x_res && y_res) {
> > > > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_X, 0, x_res - 1, 0, 0);
> > > > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_Y, 0, y_res - 1, 0, 0);
> > > > +	}
> > > > +
> > > > +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> > > > +	if (error)
> > > > +		goto err_power_off;
> > > > +
> > > > +	return hx852x_power_off(hx);
> > > > +
> > > > +err_test_mode:
> > > > +	i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> > > > +err_power_off:
> > > > +	hx852x_power_off(hx);
> > > > +	return error;
> > > 
> > > Your new version is an improvement, but maybe we can remove duplicate
> > > code by introducing some helper variables:
> > > 
> > > 	int error, error2 = 0, error3;
> > > 
> > > 	/* ... */
> > > 
> > > err_test_mode:
> > > 	error2 = i2c_smbus_write_byte_data(...);
> > > 
> > > err_power_off:
> > > 	error3 = hx852x_power_off(...);
> > > 
> > > 	if (error)
> > > 		return error;
> > > 
> > > 	return error2 ? : error3;
> > > 
> > > In this case we achieve our goal of attempting to return the device to a
> > > safe state in both passing and failing cases. In the event of multiple
> > > errors, we return the first to occur.
> > > 
> > 
> > Right, this would work as well. Personally I think my solution is
> > slightly easier to read though. In your version my eyes somewhat
> > "stumble" over the multiple "error" variables and then about the purpose
> > of the "? : " construction. This is probably highly subjective. :-)
> 
> Agreed, my suggestion is a bit unwieldy, and prone to uninitialized
> variable bugs. However, I feel that duplicate code, especially side
> by side like this, is also confusing and prone to bugs in case the
> sequence must be updated in the future. As a compromise, how about
> something closer to my first idea:
> 
> err_test_mode:
> 	error = i2c_smbus_write_byte_data(...) ? : error;
> 
> err_power_off:
> 	return hx852x_power_off(...) ? : error;
> 
> This is nice and compact, and ensures that errors returned by the two
> functions are reported no matter the flow. The only functional change
> is that the _last_ error takes priority; but in practice this does not
> really matter. Normally if one I2C write fails, all subsequent writes
> will fail with the same return code until the hardware is recovered
> somehow.
> 
> For the corner case where the code jumps to exit_test_mode with error
> equal to -EINVAL, and i2c_smbus_write_byte_data() then fails and changes
> error to something like -EIO, I don't think we care. After the HW issue
> is fixed and all I2C writes succeed, the developer will then see that
> the number of contacts reported by the FW is invalid anyway :)
> 
> Side note: the '? :' syntax is just a shortcut that sets error equal
> to the return value of i2c_smbus_write_byte_data() if true (failure)
> without having to declare a temporary variable. If false (no failure),
> error is assigned to itself. It is perfectly legal.
> 

Thanks a lot for your detailed review and explanations!

In v3 I have changed the code to your suggestion above and also
addressed your other comments in the initial reply. :)

Stephan

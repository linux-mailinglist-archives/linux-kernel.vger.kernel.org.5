Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2330C7DCD11
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbjJaMh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbjJaMh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:37:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469BBB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698755821; x=1699360621; i=wahrenst@gmx.net;
        bh=ag24Y16BKW7q/v3C5rXU1lpS2I4ZWF+C4wzfWUi35jI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=PMQqjByMhtFGgfr0G6xWrchsOP7tnFF77eXWAcn1YaDsTSh8gk7qyaFLSIffjofW
         lhzfBqcRfeiZO/tfvF5jOz0EoZPzJkJMjguY3SFA3xQBNFpAjRnJdD98rERsvZKkp
         +H8PSZU0GoLBp9Ro36jm+ebXKE07ZsKjIwrnHM0CK563eccfNrQ696nVirbqTQm9V
         yWaFmaSRkSDG6kgMUR9jAKjcQYn30sqL+jfwRbyrUgF/FC8bW0ly2I3nU4FBzQ2Nf
         B2277C82TIBQxSzj72OLMqNGDN8XMA/ZafeIz5Ehfo41Zd0aT5IgYRaesm9ClWcJ2
         eVHgQjB21S49hW6KwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXyJ-1qxPvO17Ud-00Z0x8; Tue, 31
 Oct 2023 13:37:01 +0100
Message-ID: <db49b19c-5bd3-4d4c-8e58-e81c19868458@gmx.net>
Date:   Tue, 31 Oct 2023 13:37:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] [i2c-bcm2835] ALWAYS enable INTD
Content-Language: en-US
To:     mike.isely@cobaltdigital.com, Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Cc:     Mike Isely <isely@pobox.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com>
 <20231030162114.3603829-3-mike.isely@cobaltdigital.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231030162114.3603829-3-mike.isely@cobaltdigital.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k/zR4gOE2uiwSLQd8j9aQUgMP0O9IWXNalB7fNmVTV4ot+Grwub
 s8n4Iq+3TKHZG0bwaiku3IpyBnbJYD7XwSAqSLzFwwPW6L48tFKJqiDvdr7iYkRt/mA1Jwc
 e7TYGouFfSsDw+OipdCagAStpU54rH+0Z65hGiId6k1xlGCA5f0qdhrNcb7WV7ecSPEPMns
 /Rb9pZgokJC1+30KdO8mg==
UI-OutboundReport: notjunk:1;M01:P0:yS/VH2Lh/ws=;VUd+xFNGakw9R8zEf0C80wB8yaA
 UyHkoeNTqaZvYTk8vlfOiM6lkj8X33MKbnb/Rot8r9VdkvlMjQyhR//e45+ntdyBFlhSYejjv
 LN2ErKrox/i/w2/4xQolaSDzBo5x8S2ssYZ4hv/duGQHwjQZUgatymKGCTSleaX0DhDfqPGM1
 g6PVh94vGuBix0MfWujB++gIWbTFiEAe8q1KBWPbDbWcl2bkKL2k9xtiSQ1BPczShqt8OXnbZ
 8wpgV+bC8hUP8FyxEdEou/tbXSn6FH8xYtZpFP0iEJ4p1CgNhI6qmMkYgvEQx3dbsjDGkQomB
 B2ESUbGsy3HM7Eg4fFX+TB6hoYSxk0qIqGP6duEp3F8XH8BLpI63IXL9DUHQ+v3FlqUyvtJ8f
 fhevTsIgWvjWklwrrKWa3ORXCB9F/nj0l/jGZlCtZJpaIDmn78i4KdrfufvYHpGrWZmOMAqNz
 vWAtc0+q5RO5XAMQKicaS+jUHiGAfSXa9VMdCv4SDt60rUmizE5hOhmQf3bZiYMriVYaroS7G
 fNTIxeZbvJO/K1shXvXuE4CJlV5bw/NOSV38bdthiYTlC3PLjMF/JJDIAOmYC6bAp7ki/qFkz
 f32J/rl7/+20txHKBtcl2xiR6G4OczJZLGKrS/jnY2UgpRajJpNE9u7ahMRqz1h4dD0Gpd8u8
 CVh3ubXMQ8TzfxHO+bVNvTm3SJRxqbcCBKelzyvxfeWH3+26xvC3mFFMhk0Qi5QUXj02siPOJ
 +eizBE5I+SNOiDd2nPqyAK2gx2MI3eaTTssODXNqifByrI2vNDhAxK1TjdJRhDBvINxeRwPBh
 XGAsMRtAwOF3MPETC6dBatNt3dWVHk7EQkDyDtdG4DEOIJ/CQtixKO0vQkHwlpyILuhQEaoMQ
 AmDZ5o3km4IFO/8pQ6hkhl55sAEDgTa7fCMl27Env1kLHD+96F7yQdUg86Y4PqVJVWSvYwd2R
 3VKz/g==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Forware to Dave and Phil]

Am 30.10.23 um 17:21 schrieb mike.isely@cobaltdigital.com:
> From: Mike Isely <mike.isely@cobaltdigital.com>
>
> There is a race in the bcm2835 i2c hardware: When one starts a write
> transaction, two things apparently take place at the same time: (1) an
> interrupt is posted to cause the FIFO to be filled with TX data,
> and (2) an I2C transaction is started on the wire with the slave
> select byte.  The race happens if there's no slave, as this causes a
> slave selection timeout, raising the ERR flag in the hardware and
> setting DONE.  The setting of that DONE flag races against TXW.  If
> TXW gets set first, then an interrupt is raised if INTT was set.  If
> ERR gets set first, then an interrupt is raised if INTD was set.  It's
> one or the other, not both - probably because DONE being set disables
> the hardware INTT interrupt path.
>
> MOST of the time, TXW gets set first, the ISR runs, sees ERR is set
> and cleanly fails the transaction.  However some of the time DONE gets
> set first - but since the driver doesn't enable INTD until it's on the
> last message - there's no interrupt at all.  Thus the ISR never fires
> and the driver detects a timeout instead.  At best, the "wrong" error
> code is delivered to the owner of the transaction.  At worst, if the
> timeout doesn't propertly clean up the hardware (see prior commit
> fixing that), the next - likely unrelated - transaction will get
> fouled, leading to bizarre behavior in logic otherwise unrelated to
> the source of the original error.
>
> The fix here is to set INTD on for all messages not just the last one.
> In that way, unexpected failures which might set DONE earlier than
> expected will always trigger an interrupt and be handled correctly.
>
> The datasheet for this hardware doesn't describe any scenario where
> the hardware can realistically hang - even a stretched clock will be
> noticed if it takes too long.  So in theory a timeout should really
> NEVER happen, and with this fix I was completely unable to trigger any
> further timeouts at all.
>
> Signed-off-by: Mike Isely <isely@pobox.com>
> ---
>   drivers/i2c/busses/i2c-bcm2835.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-b=
cm2835.c
> index 96de875394e1..70005c037ff9 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -235,26 +235,22 @@ static void bcm2835_drain_rxfifo(struct bcm2835_i2=
c_dev *i2c_dev)
>
>   static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_dev *i2c_dev=
)
>   {
> -	u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
> +	u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN | BCM2835_I2C_C_INTD;
>   	struct i2c_msg *msg =3D i2c_dev->curr_msg;
> -	bool last_msg =3D (i2c_dev->num_msgs =3D=3D 1);
>
>   	if (!i2c_dev->num_msgs)
>   		return;
>
>   	i2c_dev->num_msgs--;
>   	i2c_dev->msg_buf =3D msg->buf;
>   	i2c_dev->msg_buf_remaining =3D msg->len;
>
>   	if (msg->flags & I2C_M_RD)
>   		c |=3D BCM2835_I2C_C_READ | BCM2835_I2C_C_INTR;
>   	else
>   		c |=3D BCM2835_I2C_C_INTT;
>
> -	if (last_msg)
> -		c |=3D BCM2835_I2C_C_INTD;
> -
>   	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_A, msg->addr);
>   	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DLEN, msg->len);
>   	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
>   }


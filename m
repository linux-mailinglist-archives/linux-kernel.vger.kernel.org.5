Return-Path: <linux-kernel+bounces-104624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8687D125
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335B12837DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069674595D;
	Fri, 15 Mar 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="N9BWLrQl"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA66FD9;
	Fri, 15 Mar 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519812; cv=none; b=Gl4l08wG8jEgs0ZPYqdCERDOtXRzdu5jDKOwbeIrD3QeJTH4vsqpahWab/aaYrO3d+/D83R9ot9sPcNHGUaVuGDsNfJSi6ukVr3CQsAdLwKn3cZ6Dv0muuimPdDowHAEuYEB3/VUtw994OMekuq+V+l4bXLXpGrjHv60HvSzuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519812; c=relaxed/simple;
	bh=s5DTkwIySF+m2pKi4KCWUK62WynJPM/KtVRLnLasy70=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=MqcnbG4oHYgjQ2n4y05nQuBCuwhlcEff8Ivgk4/Epm0UjA46MtiQeZ1QbbWY7L0WPtCwuvwEmmgp5wW+xfToxGtHBPxOmSgtc/wWr367OmHJTlzoZTARyO8uNn9LTynVGI609f9uioZMmqHc2KAUGtpGE/RpSqWVd1YMmqn5fN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=N9BWLrQl; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=rDl8Gl63+W8qCVStnCQIWeYlrKOyDgpEfpCSq5O/cpY=; b=N9BWLrQll2uYbJ
	G9g6kwsPGlK8wbxrgZxKhOzYjYjGUgpPaSZPeHOPSctI/jl/4UGxJ0umAdb2y/djtETwS9tpU9S3/
	2rQeeHY1rLmwbVn1EKdreoOrt3FfC6siaVEGVZCuCCxjIlaV+skJfe2DQl8m9TbTrhl6JjbtlLPKT
	9CYlKHN4VjJaLRcALXsp5AzuhXT6i8RZbFw9vEsCwSe7i50YZkHfVsG0lhMJ+0OMBvpc38F1lT3k3
	7SD1g2ENS9WH83Fpg+5Oc3vA3vTSSdQ8RlsroGzbqkOgmVbxheK0cyLQv4JeUmv5F6H9muRqUlDaB
	FSCjgLzcEO8yWOEep1dw==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlAKv-006nU1-Ek; Fri, 15 Mar 2024 18:23:15 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlAKr-0001JR-Rv; Fri, 15 Mar 2024 18:23:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Mar 2024 18:23:09 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mt7621: allow GPIO chip select lines
In-Reply-To: <d562be73-ad76-4450-8bff-38ed5d144714@sirena.org.uk>
References: <20240315015708.13948-1-justin.swartz@risingedge.co.za>
 <d562be73-ad76-4450-8bff-38ed5d144714@sirena.org.uk>
Message-ID: <2dbc59c9133542f6f8bc465113d9630b@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT894iPtvyNpNwimkSi+K1O+PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIss2oH4Yjh6Q4paNNh70vrmKlRYN8+ZW0XX0AH/7tz8lOUWMR
 3Oz/N19DDfqg//ykQCB4rUl3suKct8rEwEjtlBjGf82vsPPH4Z6bBeyJ2ioKLll7c1zqbZ0Shnfk
 f76m6WzjgyOQ30CX3jGye0AgO43dPg2t4siixN3H6ipUQpv7lGF6/YptqkgVvhGhnJzzWmuNA8WT
 ybi1JN85FSnfKaZl5e9CnNR0t//S8nh6vX9JR7tTkgtGxbJXMnaWeORi/IOL8hFK8UwSRsjj826v
 xIvoo9siXVea4yN8+JzC4p2qtoJeAaAIM5zNlwLSz7Wsk0gIc5BoXwuU0D0C60f5uvdXFZsEUcDk
 8TfE1VxuxGc2M4JzCc//R6Wyn0xEa4/gbKRUuwP9TxU53J++//mag2wVXO50BuTihrUiUr+Ne0YD
 3ddZG295JphtZpms9X0aBNANCxNWMmHXUTEMGGbKThOghFKJuzFdJ78lk25pCKnYrhUnk1aI/tYo
 PYfrgLItviC2z3vIzjh1mXBwO7cA3LYE//971/IPrjStHq+sLtv6f48W6vJ1YXzwg/yHdBoe6D9l
 C5HcnR5sMHCtNqaTmXQ4BkBE3IhMX1f/+suluw5k87r8vepAOoS2eUqUWS3rIOs6OFebJBWcGqKs
 Jc1xjt6Txl9yx/3BhqO3m5yd2tj74O4hBSz/kkmPgL+fgIguflsMx6vatUpjecZPSp26Cibz+c+6
 E9r+LeeFE0l/CXNPcZxhMMHC7u4wbACXQkws4q/WKvSWBPzknbkTJiNN9rwBJkpKiGGp8ai4iv7H
 Q04RFZ4oobg8BBg3Jq+ntzj0FowsI0DXck/yx+ZVYiqsOvAPPsA1Nn6T/CCq0ZTp7nFb0SrorDV4
 8Y4UfMHtO/7HMnBN81oKcFIPKUNYVRCluVFfEoXm0/FPF8PR0w363llwyMFXKarlqLFqhfrB0GFR
 NCI72pnwdS+UMZgGNjw2gmyaDtrWPzIOQpV3d9KAZvFEy4yZs8FnQMzvojpIo6wEKULl9qYjJqeC
 CacQRjWWfmKrLjRFuOfsv9pIlKVsvXNK4117w0+Iu7iq/3ilwajFT6Qh9VybPYnXpWlnmHX0yg==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-15 16:45, Mark Brown wrote:
> On Fri, Mar 15, 2024 at 03:57:07AM +0200, Justin Swartz wrote:
> 
>> Add the mt7621_spi_set_cs_gpio() function to control the
>> logical state of a GPIO chip select line, agnostic of the
>> electrical line state and activation polarity.
> 
> The core should handle GPIO chip selects for you?

As far as I can tell, it doesn't - at least as far the state
of spi-mt7621.c is concerned prior to the patch, plus kernel
configuration choices, device tree definition, and other
factors I might not be taking into account.

But maybe I'm doing something wrong, or perhaps have a
misconfiguration somewhere. So, if you're able to point out
something I've done incorrectly, it would be appreciated.

To attempt to confirm if the core will handle my desired
GPIO chip select lines without explicit state toggling,
I tried to set the value of use_gpio_descriptors to true,
without any other modifications to spi-mt7621.c as of
commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

[... Sorry if my tabs decide to be spaces instead ...]

---%---
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -357,6 +357,7 @@ static int mt7621_spi_probe(struct platform_device 
*pdev)
         host->bits_per_word_mask = SPI_BPW_MASK(8);
         host->dev.of_node = pdev->dev.of_node;
         host->num_chipselect = 2;
+       host->use_gpio_descriptors = true;

         dev_set_drvdata(&pdev->dev, host);
---%---

I use a smallish program to write(2) a few bytes from
stdin to an spidev node.

---%---
#include <linux/spi/spidev.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>

static int      Device      = -1;
static uint32_t Mode        = 0;
static uint32_t BitsPerWord = 8;
static uint32_t MaxSpeed    = 100000;

#define BUFFER_SIZE 4096
static uint8_t  Buffer[BUFFER_SIZE];

static int  openDevice(char *);
static void closeDevice(void);
static int  transmit(void);

int main(int argc, char *argv[])
{
         if (argc != 2) {
                 puts("usage: spiw SPI-DEVICE");
                 return EXIT_FAILURE;
         }

         atexit(closeDevice);

         if (openDevice(argv[1]) == -1)
                 return EXIT_FAILURE;

         while (!feof(stdin))
                 if (transmit() == -1)
                         return EXIT_FAILURE;

         return EXIT_SUCCESS;
}

static int openDevice(char *filename)
{
         Device = open(filename, O_RDWR);

         if (Device == -1)
                 return -1;

         if (ioctl(Device, SPI_IOC_WR_MODE32, &Mode) == -1)
                 return -1;

         if (ioctl(Device, SPI_IOC_WR_BITS_PER_WORD, &BitsPerWord) == -1)
                 return -1;

         if (ioctl(Device, SPI_IOC_WR_MAX_SPEED_HZ, &MaxSpeed) == -1)
                 return -1;

         return 0;
}

static void closeDevice(void)
{
         if (Device != -1)
                 close(Device);
}

static int transmit(void)
{
         size_t length = fread(Buffer, 1, sizeof(Buffer), stdin);

         if (ferror(stdin))
                 return -1;

         return write(Device, Buffer, length);
}
---%---

If I send write some data to a device associated with one
of the GPIO chip selects while watching the signals on the
SPI bus, I can see the expected transitions on SCLK and MOSI
but there isn't any change on the expected CS line, nor any
others:

~ # printf "\x41" | /tmp/spiw /dev/spidev0.2


A rough diagram, to show that although 'A' was sent, the
chip select wasn't activated:

       ______________________________________________________
CS2

                __    __    __    __    __    __    __    __
SCLK  ________|  |__|  |__|  |__|  |__|  |__|  |__|  |__|  |

       ________    _____                               ______
MOSI          |__|     |_____________________________|
                      :                                   :
                :     :     :     :     :     :     :     :
                0     1     0     0     0     0     0     1



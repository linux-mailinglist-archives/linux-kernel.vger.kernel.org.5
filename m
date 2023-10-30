Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83077DBBED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjJ3OiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJ3OiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:38:20 -0400
Received: from sonic313-19.consmr.mail.sg3.yahoo.com (sonic313-19.consmr.mail.sg3.yahoo.com [106.10.240.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B21FC2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.in; s=s2048; t=1698676695; bh=z6S/Rs40qfHcv0FOZ990q0uOWmhbpZabeyMWApTv4D8=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=LlOi3dclzL3Ij9HocV9AhH0bRcROaeIxoVHQB0rKblYgW9eemnjCAHAvudGgDS2HiI4UkZP4FN42whLB89bc4HwnaLBoWVel7otQRZJhpXvGgwN5v2nVva1/xrcsqf74Wz+PzjUACuZHScw919+ymYafxhgS6IzfCCTp478Wzd46Hg5o7wp5QrMltEyHYxAy1I3VFQcHW47/EARaLtk+0WcWorxANznJKO6F1av9xJsjm7LaeeCIu0Svh1BWpVk3PpRjgiBSUT80FS7YrJPjcai/EYpuNcn/H/Os9OODPX7Ez3zFs2gqrqvFoSqL8+HFtdW+W4n67ivvrQ6LfhR4xA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698676695; bh=+/kspEJeOfvPYwQNRU2lkLjVEOS8tnHFOctROJay1NT=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=iJWPWaBKmUkkxfod8IgKeqPx1Cpx2RoioO7J7fK5u2vJFOHyar1vkAJVV7zPbGCx6NUMLc84sp8kafFmqDEBETpMQTerj4jzy2ibtiPi3R5PxIJLTWK+VKOmBXh2a4oDcuBenO0ZbSXjl4BlIJfF9BtjS4AE5JSZ6N+1ntezW8AZJFf6Lf06pxTWgb6o6qoH2IwIrJ7yqocLltGDEfD059uGuj94L1yLkANKTdBO2EhNqKuAIZDUSUDhH1iR2uAcPsMKU+sIAufbxDWAcJP5y1pbfdYNegvFw/ruveLspb4dbKdo69dsvpohnV8YMjhZiGoJPUZQEBM9SlnYg1xAhg==
X-YMail-OSG: NIR1aasVM1m1F10ISjLrLw.U1cxV08kf5FY4n64.JkH3MXukbil.03__PWo_hOl
 ZSAVll.FhzKbi_49vzUJvqUzswVAverXPQVK6_zl1jUav6MGDgzwTcSc3N86sNtqqTpi9BmXIM2Q
 uHjyT_N9elY93RtAu.3mTKNGZO8ZbsB7IAmaz7CTTSB6zYIXGOoCd9tDgvmPL6y9YQqPf1_5I.nG
 nJ8esUB30iZBVivf9oWfUVbUQHNFxZJje9TI.b4P0BTWhoRXgrHGRuQRZwq7JFjB46ih3yNnUY4.
 Vmdsy_VbZIttqF69_dMzTBN84xHSxiTyDK0W6g3R9ripkJE_wBRENH5ikT.OalQ3vbUTjkWyHFbr
 bTZWn7eDWWYRmhj20yq2HVqiYsghyl_5qmoQtVF7P.tU95gynqVpi_6bK9pSbe0XeJSZhG7vmcM5
 c3ZVOvVTeOWRN.aTOzkmrePenE0YIPF6T8JDkP8UAa_4ylKZKK9v9ho._Dn5EF7ospt0gGfraP4U
 tg9DfvjyoyQkmdx23O20u.YDlyjCX6m5oxa_gV7F2u9pGu4f_aSjRNcJjVbpvjZ3I3W0lyDPWAeG
 7vE1ZzxkaR7i4ISoqVCDn21F2ksCCPNmPcNiGLh_mswCwY7rTeZdsCCiEsfwYe6dQuZ2mtcfFQhR
 aqlcTPgt2MVoPI8jXFzDnfu5RAdKDho4iJT0MxPjngkK3inTNjTaOq.uoz8d0.zqEGg_3C1COU2H
 MqZXWQpilrTgSTydxeWLcFoTkOTBYe5laeZXIyT.iqZTINQrjC0dOVLk_rA8_zd_gOc7LzzWQCuq
 vjTrVnfTMYeqgi7YTwSSXKjBoNwQ8bkMUf3rV8N_oSx0LNS2ieToQGw1P5Bi_OloaqsOUiIxpMQG
 6Tc1.F4TAMM7m7ClKU1WK5PO6JrfQ2sZW8Ru8.7gPydy1pn3Kz8HMQTAIa1DtKt_3MhgarMR202P
 3TtAVfDEZZs_oDinHVwdJpJR2T80Lj3ImEIu707bz.BstQoK10sV_d6Ow78ICHzxq0D4CneTUJIO
 kR24zDaVNv4rSiH37GFyz_yM.LBMqwAZ56tzfdJgsXnfXS_Dc64RZXp505fXUiDE30LJ5PuoWNMd
 X5wM3KvBKtwoMOo9IqjV4iHNXo63s4ImggjtmlMCYG27B.WeX_KtNyI3ixyjKMDF6BIBd4wUad.1
 PkcyEsJ5h4msvas9Tl2uW1agBoT0eqy26xJ76C5HHFP3qDX35Wr1zqTz.EKkyWX18tazPLTx23iL
 p4VWhGX8Zta3W3NUf5hPtDe7hFEdlJYSZCjIwRSuKjNk4MrlLZAAH3Zs_b149NGIbg_RqXkJOka5
 0EE3.l2OV8Gfd25_.RBx_LJmgGMvSDIfkreP_IOibhcKg5EDVl9eapbx4_vSy2hEjJea0dya3IV5
 39j2fmcnYxZXZbKuCYJdUZ6sX9XaLDNLOQC5InpNYFOQK1i_188PfvhR0YOc_SMxkTR8WE2nXRWv
 r4KiQQaXhv9OpAIVH30jRkzA.ryK2E5FGAqg0f77080ubHyGGpPugRUGe4bjQYfjTRgVrI_ZEqlM
 7jH3CHuiXOnSRJx.jdzQ0MSj1JYRwSYyPixvaVwLLGUr3eySMygTi96BicvPYFsOJe1PymtkDsqa
 iGFaNYQKpFyXoDmQ4mLD95bpZS7jh663zHdfHWB6ac2BC9WDUjyCiqFjoCP5iJohSc6C8WWprDSn
 frnZJCCZtvjLPTLWTAXQ9lYD9gnwUjLs25hEhrd7bnnt9bQM2aUoXHjSCLvd5rYTYU4cNEnqLPrp
 OdXa8DNG6zdcPgjRNyMR.K0qgF3Jj6HonaOo.Vu1.9ZFON0luEvJtJ_DQ..jseIyboAlVW6ARJoS
 zYK4LlWlji2kuuLzOiYVv7YWGRnEwN94i1UJZU7hn6IWumS5ECyZNR8dzxXmNPQkKPxQvw.byn7U
 doExtLjxOcPwnG4PFuem8vCaDaT53JSk1saaav6Lgnzf0I4biTWY1pWy8xGetgP6UmPwNs5tIJAc
 nSWOXMB22LZdENbbv1UYQ44Kzh0Oedo.sX04cpVAhuOYnqoPtNz8XPwkzZ_t6NV04beZDcGMwQZG
 ckVq4s946lgRjj76nMKY_S3EOJ5yiylcaqH69FRa.i0Av_D.NOj4ZBNFUufuwL6SggYLZzA9HBoG
 S6i_YHztsNWsM18gZNZ4XNfLeVOIoEgNrzAA2jgdgGOx2eoPRGsjNcNtGa5qWqHRKYPzVa3e6HS0
 HfI0nvVL9wOAngqJATHjom6VbI7uLPA27wcYQjyu0pkW2eAka3Q--
X-Sonic-MF: <coolgoose54@yahoo.in>
X-Sonic-ID: 1d444252-8d78-4368-8a3f-db12921b4529
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.sg3.yahoo.com with HTTP; Mon, 30 Oct 2023 14:38:15 +0000
Date:   Mon, 30 Oct 2023 14:38:14 +0000 (UTC)
From:   Cool Goose <coolgoose54@yahoo.in>
To:     Kalle Valo <kvalo@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux ath10k <ath10k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <2072544843.546737.1698676694520@mail.yahoo.com>
In-Reply-To: <1242733089.791333.1695658442201@mail.yahoo.com>
References: <1209906123.2716993.1695416371605.ref@mail.yahoo.com> <1209906123.2716993.1695416371605@mail.yahoo.com> <ZQ4vQNe3XsArwWQT@debian.me> <87a5taa7lp.fsf@kernel.org> <cafad11a-d7c7-4b68-880a-d6e05578fa5c@gmail.com> <1242733089.791333.1695658442201@mail.yahoo.com>
Subject: Re: Atheros QCA6174 ath10k_pci fimware crashing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21890 YMailNorrin
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does feel like a hardware issue, either the bus or the card. I had Windows dual boot on the laptop and even Windows is complaining of network issues.






On Monday, 25 September, 2023 at 12:14:02 pm GMT-4, Cool Goose <coolgoose54@yahoo.in> wrote: 





Laptop model : Lenovo Flex 5, running Arch Linux since Dec 2019. No issues til around late 2022 when I would just disable wireless and reenable from GNOME system tray NetworkManager applet and then things would work fine. But for almost a couple of months, constant firmware crashes and device cannot be recovered even after disable-renabling wireless. If I remember correctly the transition to constant crashes coincided with me upgrading system, thus I am reporting here.

Just in case it helps, I tried looking for a small system journal from the laptop where the firmware crash was included, and posted that here. http://ix.io/4Hpr

I am trying to find out if this actually looks like a hardware failure becuase in that case I can call it non-recoverable issue and look for a wifi adapter.
If it is hardware failure, I am trying to find out if there are any card settings I can tweak in may be BIOS that would make it work in say a restricted mode.

Thanks.


On Monday, 25 September, 2023 at 06:15:27 am GMT-4, Bagas Sanjaya <bagasdotme@gmail.com> wrote: 





On 25/09/2023 17:08, Kalle Valo wrote:

> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>>> Sep 19 09:01:11 hostname kernel: ath10k_warn: 149 callbacks suppressed
>>> Sep 19 09:01:11 hostname kernel: ath10k_pci 0000:03:00.0: failed to wake target for read32 at 0x00036044: -110
>>> Sep 19 09:01:11 hostname kernel: ath10k_pci 0000:03:00.0: failed to wake target for read32 at 0x00036044: -110
>>> Sep 19 09:01:11 hostname kernel: ath10k_pci 0000:03:00.0: failed to wake target for read32 at 0x00036044: -110
>>>
>>
>> Looks like hardware issue, right?
> 
> It could be a hardware issue (for example a problem with the PCI bus
> communication) but also simply a firmware crash. These kind of reports
> come time to time but root cause is unknown.

> 

The reporter said on Arch Linux forum (see TS) that trying older
linux-firmware package doesn't help, so I suspect this as hardware issue.

Cool Goose, what is your laptop model?

-- 
An old man doll... just what I always wanted! - Clara



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F177ADCDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjIYQOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:14:17 -0400
Received: from sonic304-20.consmr.mail.sg3.yahoo.com (sonic304-20.consmr.mail.sg3.yahoo.com [106.10.242.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7514410C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.in; s=s2048; t=1695658447; bh=pXV/R2SyjuGd7opptvW7hVPSPNpc6bC5lFOXnck7eDE=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=IVfMJEX2RlicrSwRjpywW2H3HudUcZF1nMt7dYWxuKzc5g+avbTpa3ELuddFy+nFMJd3vk+sAc3IcZIOLdQ17uHvGCxnBg0mC6c9c0EAJNt6zolriciSO0PMuPqeZooDIdAFSXKRGwKwNpEcQbL6KWGE6k353X/IE7ndIkBV/kmXLkCMCX/eUjI7eCCk3/n7HcPOhAo9WGUdm/iCoYbnlSBBI5qvNkm5khsDjlmJpWn3Yl1xljNHD2e/qjZxLGmObkXnn/z7NP9/XbwzvJrpe++ES/TCNTADX+1OCqmcHkybB3mlDJxbP45PGp7LcPgDp4LopbLFD9buutaFFbWLRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695658447; bh=Ba31dePcxMvXIVsmTeHj5WzBvogH3sedoUpH3gwepMT=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=X2hiHwz2RFuuCR1Z1N8Z1YlRRkh1sVQtvn6valtmL4QjTYVUSZK8LA8q9TfgvEga0o48TmVWi2VpH/7lz0JWarfvc85BKV4fCJZsQYV6ayU4nmdrpIvwpxgjt2n2/iZrK4ebqQ2LvSOKrCoT58a39A3IzFDu6HrRswOxjJpooLI3GBATmKZnSK9Nt4Q/cIcXckirodA9MTgcfzErtqG0BVy1AUaPYvT0nx7ixSbqh8V6W+lYXgTIdsy+BbH+0S3V8dtzlyPKOQzRTLYDi/HnlmDfZbB8DfCSIKzKMRgZ363zs+UvwNpdzwKQ//eTFDSNw6yKDFFqMc1zCrfTq32Ymg==
X-YMail-OSG: DTKVQT4VM1lQE6BFK7D53Sgd8gJKqyUebGn53xvGOb.B2L.Fl7wU2a4Tt43iYLb
 bK2dVA7Ajql.6KApBMaFvnwKxRGbPdRu2tM_bNLJbcWM985Oje63nb1b56p0gN.dKCauOvHqrAHS
 Rjwt3zJTBCd4vY9tuAM9NfkCgub6nIcVH1rbHwUrnXn0m.nojpWe1v67sZ_YzTwRJBSiLYeVmedd
 Uo5yFXwZivU45AYhYBc4sDF.KBbQ5IrqvoF552mQUziQvo3cKF58qECvb8yEjriAkHtjBcJTvaij
 rWIfNuwADEyOn7jcT85RxSYIlxeSU8dE3pNk40pG.9tEJDtf906OKiyxgNTnpADKl7KI_zcEhBIA
 NabhmKykVK3lODMSUOOz6sjvBhBg2Et8jZ607Z0Wrdp1VJfpQ_uFx39j0PV7HLpY_Qi5pLbN.Bvp
 hIrYHM7U92Mqq7G7eMepSNEwVTTll_bItHfPCoY2yryAf6K7O1oB4jDwpxhqHopro7SLs5YC7b9g
 9i1NzIvtiGiCyzAVoLIjOzvNBucg4zO8c3yjRStZDML9_NGqY4WWYEpQ7cGb6.HBr.GH605ITznB
 SahXDUFRgcg866qN0D7jrHBZAFWdVIVPBUhYFZ54EXqOhTSlOCaTXMXAwHj46RQK0T_l.yyvUTsA
 I14rbSX4rctYUwm_EC8g7Ozgaj7Hlq5Fll4YlPSG9YaD.mcXKZQD.bXyjPSM1k8CmUG093A6Y3Hl
 tI6mENz7FQ_wtGV0vQUNQgv.HR8KHEgm6dKnUepgZjC.vwOGVuREIerLEIBdMorOdZ4ntAtBaRDW
 6tIR9NxGPYnkB1dRF6BJyN0jJVoZow3l98m64C.eC5iTdC24K55iQ9hhmeUM9U3TnkcBRF34fDcN
 FAxKFPBlNqlTPnvwGh7y08J6MI59NUNYGqeSmwFOmnO2cliwha5dq_3QTLMel__T7F7PmEzpU2LC
 geuiQTRggYkk5Y3NFpiynPCjG8H_LdFZzjYR37snKR_RfLD45djmnVTOuLuXpLtR.TNyr.biXUsq
 LVmVkcsdnF10zHi6IvvvXvCRQ3rJW47m1Eqe7jCYDrNqocmL1KurloSaDEPdC.g8ggySNVWzfghL
 fNlTcPnp9CIZm8n5_ShejhhnyjEfpiQCGmfyTRdBdCxBD26h4I45wEAWtAOu2.g9en1AMOD.ezkc
 BSqtMYVkZQpGX0aPtkAQ4LrdM4OvL2z1rcpJMa0Nh6lHgpmHXY8KDa6vgc4AjMpsyEvgYDYDDZAU
 Nj5ed5RNTFnUttijeuasIcONnXhUoPDl.h_x5GUQhsw8tvOFYEXQXc9hfisocQ3FgDGqm84RRdG6
 dVwKpvVseO5CMJU9D_w626vZHKFugwPrARDHedc5zlooi3PVwUeef4JGrYXkKKTdcYZhqfqSobQa
 O6_xs0MK27xA2xrtW6gxRRfjPWVnM3s6750fK1Zj7.KBrzywYjyoij4fetEL0mjRixb2DrqtUEKh
 QhG4UZjvviD068iynBQyVuev4QivSA_VoWK0EwnUzFRq2rK1g1Q88V_gyT0oAQNPKcxabDPW.KYu
 xqrxfXqZxwoqCvEOcm_XRyu.GdsGQeRJzPc.8axnhimME2AGiP.GXJncXeAw.dKCL5kIsQOkkMmb
 58UxTcJss2ImLVVjZCfYCfHX0UaViT1ka9aNVS7utcdsdWrVQ_0l_03iyDc419OvH_pdyk8Qagy9
 m.9IzsHXR3Q6YqhFT7BUucxsBRjYCvA.3CXwUlcXzM0Jp.kvyFBmaI3jjcm06pg4VBayf2cWiTgg
 xfqhn28O85jfNLZbhZUzRh30LBP3.GZBeSi73hzAJZrUrili6RqjAvuojTT7exne8N6.U8Ptch2O
 RtKmzzCR.IlWtZaDLMs3cuHTUyBbH4dScjV5wYqAlZvK3y9.2EXopUIPDpNSHIBBlx30iv1tk_Gw
 SNmIBassg5PNSQA45r3bPteGUHPKWDQC9DDR0TJfVLCRxFwrpzqYKitXu1QHEB8F1fbre2C34hY9
 2mWt6kYbNRui.gx1J4eA8GbHJwUC_NXZA_6rUOejWEzHilHoAFBAEOqSwt1bV8G02.gRQdkdo3du
 HIR7gGA8OTNt5Csn3bG_dyLcPoHEAB8uOP.TRz.n1uvJ1R034ZAhKe1JYp.59WpPIDzs_O.vvfKm
 QxaVTZs0tQ_5xf9V_gBm04h9lCmLXN08_gCctW.6L3J7Lep_ol2a5n_EOSSzb3Q.En8aVj1yK.sU
 WQMq_Zca42NQkvkRwVBYCkFsxCnhUJD_Df1WpyQrulVS.WPb0Y8Dx0WbBxA--
X-Sonic-MF: <coolgoose54@yahoo.in>
X-Sonic-ID: 0523619f-5a15-44a2-9b06-3469b98f5e13
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.sg3.yahoo.com with HTTP; Mon, 25 Sep 2023 16:14:07 +0000
Date:   Mon, 25 Sep 2023 16:14:02 +0000 (UTC)
From:   Cool Goose <coolgoose54@yahoo.in>
To:     Kalle Valo <kvalo@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux ath10k <ath10k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1242733089.791333.1695658442201@mail.yahoo.com>
In-Reply-To: <cafad11a-d7c7-4b68-880a-d6e05578fa5c@gmail.com>
References: <1209906123.2716993.1695416371605.ref@mail.yahoo.com> <1209906123.2716993.1695416371605@mail.yahoo.com> <ZQ4vQNe3XsArwWQT@debian.me> <87a5taa7lp.fsf@kernel.org> <cafad11a-d7c7-4b68-880a-d6e05578fa5c@gmail.com>
Subject: Re: Atheros QCA6174 ath10k_pci fimware crashing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 YMailNorrin
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D35480F7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377294AbjLLUQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjLLUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:16:52 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84ABC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:16:58 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A27225C00DE;
        Tue, 12 Dec 2023 15:16:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 12 Dec 2023 15:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :subject:to:to; s=fm1; t=1702412217; x=1702498617; bh=2+cjEQfIm0
        O3WXRt9PnhBi4A8k6n3UUDe27/DIffOyQ=; b=K5TXCCeO25/aCqPV7YBAgfKmGS
        aSeN1BWMtdPg11rZArhXNrrCkKoJO5BD6DPDQFTJgMA8JODAt66zjQXQJDt5geqA
        MmwNRRpxlfknPslbKGKS7A1spmpJswJXvi246JgJv3/fQHE8nvZ7eaKR5c9cmjXJ
        Pc9xacBTe/AP6WEV9yqEEjZGnjuNDVREP7ecvUHBcN9NMNUyqa00Pv0KWC/bGyI3
        3VHamOKAXx56Ay0SHaotFwXmbwr2yKsHW+wFVOsSAUiAsxF+jPMAhcRe8BT68/bA
        wabvq/yPdy7HnRBjMg7Db4vSrZEnzwnQUCI+jIwlwFxlOTeWlN92mZQGtFMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:subject:subject:to
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1702412217; x=1702498617; bh=2+cjEQfIm0O3WXRt9PnhBi4A8k6n
        3UUDe27/DIffOyQ=; b=dOt2vi9T1CNWYGTM9MxuYhob3+lGrp/udilRLhnfkRIh
        /bqzybwZu1IKsNr1mPkHrAGPcb9jD/XaTrRIUb2mazpkAmFdnauYVboBMRq5ns8L
        4bgf2xhQyaeIw0NS1Z9TQqFWubx5X5S4DjD5VIYGkFm/LbOQpkOwfI004a6vB52M
        rpXFUZMUt01dunX16APepmlqTLAndRkP2lI8iUrfyEm5GTsP+h5H77uTxeOYjqIP
        BuPAk3aXfo4XoNDurwQlH9nXNhIBZSe3MDUr8XQQIaOrQJ3S6LndhestNzrrwVrH
        8714kHsavO03gFaWYfglUXnjfVUTNZmR+3Ut9tbvmw==
X-ME-Sender: <xms:ub94ZWjgb6cUkyH9imlsBCYzY0KfOHQ1vSYL3zD8PcoacSy4mZjTEw>
    <xme:ub94ZXAYFibvdxkoWUwNQFW2fPniVRTzjQ0oidgOH60eFxn0hM2SSnzunu_QEbAsY
    EvT0_pLA1xaNOVOFvM>
X-ME-Received: <xmr:ub94ZeFf_a-1RI4efGQ2zjmDVHIt_RV599vmgVAnsm99zoCJQ03pBIvX5VpNjYH-1gBUED6QIAtMQ6yfKuqKnRZakHDDFIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehgtderredtredtnecuhfhrohhmpefirghr
    hicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
    eqnecuggftrfgrthhtvghrnheptdeukeefuedujeevveegvdehudefudekkeetgeejleei
    geefffdvuddujeelleffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:ub94ZfRkVVncGNzk6J1iRrSxgLF-uEblJbG7clRM0Sq_aViA26UqUQ>
    <xmx:ub94ZTz4QqcIt6WhrCPmRZ4vLD5TNs3TOG0ZCuxAtpqqXo6nuQlDPA>
    <xmx:ub94Zd41wMLTlTjyHiQ91dWdgckX1YukVfK_kN9C0r1ScS2m14CNqw>
    <xmx:ub94Ze9QRgnhkWevkRBtBqSYUTICrpFky-jPSN7ThbGDuiliz4jEmQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 15:16:56 -0500 (EST)
References: <20231212165637.17618-1-garyrookard@fastmail.org>
 <20231212165637.17618-5-garyrookard@fastmail.org>
 <6a065daf-3639-4a87-8ab6-7018e0362900@gmail.com>
User-agent: mu4e 1.10.6; emacs 29.1
From:   Gary Rookard <garyrookard@fastmail.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: rtl8192e: rename variable pHT
Date:   Tue, 12 Dec 2023 15:14:01 -0500
In-reply-to: <6a065daf-3639-4a87-8ab6-7018e0362900@gmail.com>
Message-ID: <874jgnuqf0.fsf@fastmail.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Philipp Hortmann <philipp.g.hortmann@gmail.com> writes:

> On 12/12/23 17:56, Gary Rookard wrote:
>> oding style issue, Avoid CamelCase
>> rename it. pHT -> ht
>> Signed-off-by: Gary Rookard<garyrookard@fastmail.org>
>> ---
>>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c
>> b/drivers/staging/rtl8192e/rtl819x_HTProc.c
>> index ac85151a6069..add8f58b5b1e 100644
>> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
>> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
>> @@ -250,17 +250,17 @@ void ht_reset_iot_setting(struct rt_hi_throughput =
*ht_info)
>>   void ht_construct_capability_element(struct rtllib_device *ieee, u8 *p=
os_ht_cap,
>>   				  u8 *len, u8 is_encrypt, bool assoc)
>>   {
>> -	struct rt_hi_throughput *pHT =3D ieee->ht_info;
>> +	struct rt_hi_throughput *ht =3D ieee->ht_info;
>>   	struct ht_capab_ele *pCapELE =3D NULL;
>>   -	if (!pos_ht_cap || !pHT) {
>> +	if (!pos_ht_cap || !ht) {
>>   		netdev_warn(ieee->dev,
>>   			    "%s(): posHTCap and ht_info are null\n", __func__);
>>   		return;
>>   	}
>>   	memset(pos_ht_cap, 0, *len);
>>   -	if ((assoc) && (pHT->ePeerHTSpecVer =3D=3D HT_SPEC_VER_EWC)) {
>> +	if ((assoc) && (ht->ePeerHTSpecVer =3D=3D HT_SPEC_VER_EWC)) {
>>   		static const u8	EWC11NHTCap[] =3D { 0x00, 0x90, 0x4c, 0x33 };
>>     		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
>> @@ -275,9 +275,9 @@ void ht_construct_capability_element(struct rtllib_d=
evice *ieee, u8 *pos_ht_cap,
>>   	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
>>   		pCapELE->ChlWidth =3D 0;
>>   	else
>> -		pCapELE->ChlWidth =3D (pHT->reg_bw_40mhz ? 1 : 0);
>> +		pCapELE->ChlWidth =3D (ht->reg_bw_40mhz ? 1 : 0);
>
> The last line changed with my patch:
> [PATCH 02/10] staging: rtl8192e: Remove variable ht_info->reg_bw_40mhz
>
> It is always difficult to know which patches are accepted by the
> maintainer but you may want to look into the following mailing list to
> see if there have been any patches send in for this driver.
> https://lore.kernel.org/linux-staging/
>
> You could apply the send in patches and build your ones on top. Then
> you do not have this issue. But when the patches you are using are not
> accepted you will run into the same issues.
>
> Thanks for your support.
>
> Bye Philipp

Okay, no problem.

Regards,
Gary

=2D-=20
Sent with my mu4e on Gentoo GNU/linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEEjsrWb+cZk1AuzV9C2li+Bks2LgAFAmV4v8MZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRDaWL4GSzYuAFpHEACxYwOhErAQCco8Srpcq/iI
tgRK7G0GMYdbXPOz7fNxuLv9AUKMijqMyXiGtO8L+koKollJqD/3l07Cnm8CAxR4
JWRu/nK8Dz6w1jWtStJxuhV1qlKenCrYPrCLOkRMG3S4VHHWnf1TOYl/l1hVu1bQ
aBBOYjQGR1tD/8rDCC/uu18iDVAW5o0uRhhYQyrCjSPmp5XNmdIPBTfLG18PtSBK
sfHA+UdZXt2wVjVgPworBuEHahBjgKG1Ev9eqaTiqNgWxxyX8APZl4smz90Jbm/W
mTL8/exIwQMLl4rtBJVD+i0ld07DWs/0Dw2kIwgqKenOHO+eb5c2KKdFbsGLiCeX
1GYwVo8zvDNx8U2SVFBVyAYQaoO73CSUG6ssr39WL37bdyXaYKQwLG8MFhdJlj9j
2yRdBSaECnLKBbYZyuIb/h8nbg3vZK+Qe+EHaDfXubFVfJt3LNm0x72Ndb+lTf84
6G9OvJpHJ3cYdU4uuTyH0oZibS8PVkBLv2aKjnZ8OCxGAhYtllB5bdCMIWD9Hyx4
68Cyp8j11fbNwwZ5Vqj6PtqZYYb0Qjb9tdcYVYKy3tBUlilwA7CquRBF5g6W9GJg
23lOk8/aaNgdZ+zzIUpduLOLiVfulh2wN9bhB77fE1XBn3PoO/8jUCTxNGd/PhC0
ooy5Ip9S0Ts73VCX4xGzDA==
=OyRa
-----END PGP SIGNATURE-----
--=-=-=--

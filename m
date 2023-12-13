Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E725810BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjLMHkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjLMHka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:40:30 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D545109
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:40:36 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so1229432a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702453235; x=1703058035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0Ly6HERW61XKD/YdVWYbpue1eQaDfbZ8RVVo6+xYP4=;
        b=rewUZHK1wEeEGVcJ88SnNSBnOORrJbG5Ql2dp8AoP5sooWR8m9OaliXH+ncG3dRIYh
         fqdQtkKXBeaK+BGPtsQzrDmleR8ur1P386CKQ82itfWX4Q4LDtGh37GgGFGZpqPDc/B/
         AGHrcqRBZ2BmJrJ5Mi3khy58axT/7SapNGWq1cj1xYNTd+sheDlKh2ciLrad6p2hClWy
         orodXagxrWuylmcV8NmrwZu7ndwt1KYXG9haDmOAqnf+EOmtlBVQv98FPDRrVAoC9wSr
         a49W4jm+Yp53/Rs8oZWFQtORgz0qvYl7bMXTmx75Fzn6WJ2GoYsUz2MmgL5lyc1CLv3Z
         muog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702453235; x=1703058035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0Ly6HERW61XKD/YdVWYbpue1eQaDfbZ8RVVo6+xYP4=;
        b=j3QVxzKsch2RgvpnXqtbCf7pdAV3gH8qXB2SdWkXWzTd0OOLBEHUPoTjrtH3HVFtKP
         fObBWQjblKQL27h2FYRGzT9Hl4Qog4Nq4vjlt9YTAzSVo5HqTuNeAhbpp5woLLL/UBCi
         Cb7oZHqbV9GE7yL5klFvuVlnQhYDdw90bNr6jYbxWizrwvV8rWOE1EJCP1PhoNwyXA0n
         MU2T4g4sPUcZNglgvpKx/qN41bDJA54Zd1jYbBMYpr5MdsXE7jU5BNvoaDqmG3RWnQq6
         Uu+ObF46DW9tWTbdoIDUA5g6BWqVZTlSk2aVsqouavZ0Jy4ZEx+YWboVmr5V6xUb5HOC
         GGSw==
X-Gm-Message-State: AOJu0YwOM9MOBwpR5rCKGvXGUQJi/DJpgUjQQ155pHmRH/ye9I3SugLu
        x0sKK1R+MsYH52Mne+U9Jf8zfg==
X-Google-Smtp-Source: AGHT+IGKbFjRp1ZDTn5emaNV0yLT0UtG6txFHNST+cXhdsrFy5XgkqtKPM/tRuWWTL+/CXMjVr7zSg==
X-Received: by 2002:aa7:da41:0:b0:551:dce6:6911 with SMTP id w1-20020aa7da41000000b00551dce66911mr1432774eds.10.1702453234941;
        Tue, 12 Dec 2023 23:40:34 -0800 (PST)
Received: from localhost (h1f2c.n1.ips.mtn.co.ug. [41.210.159.44])
        by smtp.gmail.com with ESMTPSA id p3-20020a50cd83000000b005522983c243sm156639edi.91.2023.12.12.23.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 23:40:34 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:40:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Gary Rookard <garyrookard@fastmail.org>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: rtl8192e: rename variable pHT
Message-ID: <437ac97e-ff02-455d-a5b0-677907e86cad@suswa.mountain>
References: <20231212165637.17618-1-garyrookard@fastmail.org>
 <20231212165637.17618-5-garyrookard@fastmail.org>
 <6a065daf-3639-4a87-8ab6-7018e0362900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a065daf-3639-4a87-8ab6-7018e0362900@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:56:57PM +0100, Philipp Hortmann wrote:
> On 12/12/23 17:56, Gary Rookard wrote:
> > oding style issue, Avoid CamelCase
> > rename it. pHT -> ht
> > 
> > Signed-off-by: Gary Rookard<garyrookard@fastmail.org>
> > ---
> >   drivers/staging/rtl8192e/rtl819x_HTProc.c | 20 ++++++++++----------
> >   1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > index ac85151a6069..add8f58b5b1e 100644
> > --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > @@ -250,17 +250,17 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_info)
> >   void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
> >   				  u8 *len, u8 is_encrypt, bool assoc)
> >   {
> > -	struct rt_hi_throughput *pHT = ieee->ht_info;
> > +	struct rt_hi_throughput *ht = ieee->ht_info;
> >   	struct ht_capab_ele *pCapELE = NULL;
> > -	if (!pos_ht_cap || !pHT) {
> > +	if (!pos_ht_cap || !ht) {
> >   		netdev_warn(ieee->dev,
> >   			    "%s(): posHTCap and ht_info are null\n", __func__);
> >   		return;
> >   	}
> >   	memset(pos_ht_cap, 0, *len);
> > -	if ((assoc) && (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
> > +	if ((assoc) && (ht->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
> >   		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
> >   		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
> > @@ -275,9 +275,9 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
> >   	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
> >   		pCapELE->ChlWidth = 0;
> >   	else
> > -		pCapELE->ChlWidth = (pHT->reg_bw_40mhz ? 1 : 0);
> > +		pCapELE->ChlWidth = (ht->reg_bw_40mhz ? 1 : 0);
> 
> The last line changed with my patch:
> [PATCH 02/10] staging: rtl8192e: Remove variable ht_info->reg_bw_40mhz
> 
> It is always difficult to know which patches are accepted by the maintainer
> but you may want to look into the following mailing list to see if there
> have been any patches send in for this driver.
> https://lore.kernel.org/linux-staging/
> 
> You could apply the send in patches and build your ones on top. Then you do
> not have this issue. But when the patches you are using are not accepted you
> will run into the same issues.

Generally, it's first come, first serve.  For you, your patches have
a 95% chance of being merged.

regards,
dan carpenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3277996EC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjIIInT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjIIInS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:43:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E810F6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 01:43:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68e403bb448so1691998b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694248994; x=1694853794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ThoAJQ7R+le+t9BWKxFb3NnyvFQ177oeH/Jedkgpock=;
        b=MbBLAwxxTGoYUm4AHC13VI60RaNrCodpigXC6BkCej7qUugH/kP58+hs8I54mzx38p
         mUIIPDZLfHaBoUaQUFPQ0sj0vh1y9spT/bS/YmRjM+O/ArGTliJPLkhYwd9M6tlqazNk
         bI9Jx7wlIXg8uzNpr8JXoxODPUy8Y9tSU/AFEH7m43st2t7Qx6aZTmvkJu0MFJS9W0Wa
         IqSZilIl6R08MR7TEBrPQr/6DWRj6jLpeyMRe8kCZDUSwZATVlUjvvaZINFLY8GdmPsZ
         m8FgIQb8i+u5KSpUT18jS75ALL9Us+gM8xc6K5fvDZLeWZyqXhS1vdCjW7Ix4UvO2L7J
         465w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694248994; x=1694853794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThoAJQ7R+le+t9BWKxFb3NnyvFQ177oeH/Jedkgpock=;
        b=jwvvWFX/NeuFhzJRXaKeQv4s+MqfkE2cV5EgVsPi7Zqzbs4PTKdvnkcG4o0SZw2VE7
         OebsSSLL5V2am18E7kTiX6Hml24rb7LSQ4b+78i6aZHNFQqvdk+VL219pG5CBFJDPfH5
         zMAbGiyQYOhjVoVfTp4i7CrjalUPKwky0Zyc3phI7cRVaFtmMZRhaRCdNKEyNzbsaCQC
         P7OlWQ+KewXfz+Ewihx6wJxLoTuP3UGWw6g88Gai7ZlfY56i6mjq2BgNCylsK7RfaRgC
         Z1oAIlly/Edq95cul/c2VP2LIHTsWO1YX/IqATW5kPV0MGukQZkehf5P1d8B3xN7lUuO
         5pIg==
X-Gm-Message-State: AOJu0YyGngnxsekmK2xwIzQHZi7JUOevKssYnVYF8guRjUkTD2V1Aha0
        /CiweYHFclLV3AEGp5mjH0nN7h4BLPo=
X-Google-Smtp-Source: AGHT+IH5mFmbkeOpk4JDcg5uSRaKHYaekmXQCVdNMFXfvc+bDuheJu2c+lU7X6vO1FKNAfuSFZUbIA==
X-Received: by 2002:a05:6a00:a1b:b0:68e:28dc:8d5e with SMTP id p27-20020a056a000a1b00b0068e28dc8d5emr12388144pfh.16.1694248994272;
        Sat, 09 Sep 2023 01:43:14 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([223.178.252.251])
        by smtp.gmail.com with ESMTPSA id i12-20020aa787cc000000b0064d57ecaa1dsm2376397pfo.28.2023.09.09.01.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 01:43:13 -0700 (PDT)
Date:   Sat, 9 Sep 2023 14:13:09 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Type encoding info dropped from
 array name "byVT3253B0_"
Message-ID: <ZPwwHY1TDOBEljxr@ubuntu.myguest.virtualbox.org>
References: <ZPnLw+njcL/D391S@ubuntu.myguest.virtualbox.org>
 <2023090724-trial-ipod-93d2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023090724-trial-ipod-93d2@gregkh>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 03:43:53PM +0100, Greg KH wrote:
> On Thu, Sep 07, 2023 at 06:40:27PM +0530, Pavan Bobba wrote:
> > Below array names updated as per coding guidelines:
> > 
> >    1.byVT3253B0_AGC4_RFMD2959
> >    2.byVT3253B0_AIROHA2230
> >    3.byVT3253B0_UW2451
> >    4.byVT3253B0_AGC
> > 
> >    Conversions performed:
> >    a.type encoding info dropped from names
> >    b.names replaced by snakecase
> > 
> >    Issue found by checkpatch
> > 
> > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > ---
> >  v1 -> v2: Name of the tool added in the body of explanation,
> >            which found this issue
> > 
> >  v2 -> v3: subject modified to more specific detail
> 
> Any specific reason you are not sending this to the maintainer that can
> take it?
i used scripts/get_maintainer.pl to get maintainers names and i am
adding all those people to the mail. kindly let me know the maintainer id
and the correct way to know the mainter of a file
> 
> Also, your changelog needs work, please read the link the bot referred
> you to.
> 
> thanks,
> 
> greg k-h

sure. i will cross check once. Thank you

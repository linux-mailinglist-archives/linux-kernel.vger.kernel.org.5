Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E478E561
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjHaEUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjHaEUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:20:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1BA1;
        Wed, 30 Aug 2023 21:20:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565e54cb93aso288848a12.3;
        Wed, 30 Aug 2023 21:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693455634; x=1694060434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THKot3DyoPDc0V9Z4riR189lVwannjnrUDVHPF85Luk=;
        b=RSYRjW+cHTqO/xJ/fYZY4NoqhySNP1xf8s0GQyfSC3cybJ6neymDdRiMWF1vtncgev
         b1q6SNoBtUQXJSIpb6hLDCEV8NbP8AoLmSyOiYa0lpvh3d32wz8g8IWQcegkKYND2Rx1
         HGJ70/lBiqKw3OKyS28V+1qTkaQc41IGHXqTo5L43ptAhTH2zyGhPweWDtbjghibgB5N
         pHJ5SZLC54agkTdhMTqYp7qsKewCALZlgNzADq4ex1i79vD2VB6EXdkCfJTyeXsLEa4e
         quNiqGy4EyNbokhT1RE5tmXseRH4dp+HUuG8TxeRFhvqu/7EyofhKIEA5hnMZOOJW/Co
         npXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693455634; x=1694060434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THKot3DyoPDc0V9Z4riR189lVwannjnrUDVHPF85Luk=;
        b=E1jlw2FclpV6uxx/OXS5m3HkoocR+5vQCCX6wd8/YMi2hQZ2bvjd9OwrigtkSA3uBF
         q/6Ia99i+9QUKNVJPkFme8W+w5Xrz7NIm8y15QHvW5KZAI4zyLpWwGzbqJXNBUV7hTFi
         Nv35RRAHg3ym8MybNPQ9n/soc046kui0hCPug0gWavD+5RE6YARIKj/wTuqbso2/sGvK
         MWRWiQT/nriv5GYgoFOa8+9Y8vyQCNDifSkNuaqxmUU7PXTnoS3UwPlvJPuSVhi1a0LQ
         PcPHgPMvOpeto9tVy17LqNcmRUyYmVUivRCL3Nxx8n5CUdX+qPdoTCdDEr3bmNkWBAR+
         kC/g==
X-Gm-Message-State: AOJu0YwnR5LJgHEnWogqhxht7me+lVkEMsyP4CXEm84PzIpvQCMYccuS
        LwEacG7NrMeGWm6YUPby1vg=
X-Google-Smtp-Source: AGHT+IHzlwTkkkiEvX8Y3Jxqf+MA2n1F4tOPt5P33LGlL0agKNv2bgY3taZ70nCL457VBx5kSuEnBQ==
X-Received: by 2002:a05:6a20:7f94:b0:14b:b42c:349b with SMTP id d20-20020a056a207f9400b0014bb42c349bmr5595932pzj.1.1693455634113;
        Wed, 30 Aug 2023 21:20:34 -0700 (PDT)
Received: from atom0118 ([2405:201:6815:d8ef:8c0f:e11:eef0:3e00])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709027c8b00b00198d7b52eefsm305172pll.257.2023.08.30.21.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 21:20:32 -0700 (PDT)
Date:   Thu, 31 Aug 2023 09:50:23 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com,
        bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shuah@kernel.org
Subject: Re: [PATCH v1] drivers: edac: Drop unnecessary error check for
 debugfs_create_dir
Message-ID: <20230831042023.GA76997@atom0118>
References: <20230815203826.51792-1-atulpant.linux@gmail.com>
 <723e803b-6f8b-ceb3-e987-4a6f83d89222@amd.com>
 <20230828133547.GA58271@atom0118>
 <b477d4bb-8647-f1a0-31c4-2658bfa082f1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b477d4bb-8647-f1a0-31c4-2658bfa082f1@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:00:41PM +0200, Michal Simek wrote:
> 
> 
> On 8/28/23 15:35, Atul Kumar Pant wrote:
> > On Fri, Aug 25, 2023 at 09:31:54AM +0200, Michal Simek wrote:
> > > 
> > > 
> > > On 8/15/23 22:38, Atul Kumar Pant wrote:
> > > > This patch removes the error checking for debugfs_create_dir.
> > > 
> > > Avoid using "This patch".
> > 
> > 	Thanks for pointing this out. I'll remember this.
> > 
> > > 
> > > > Even if we get an error from this function, other debugfs APIs will
> > > > handle the error value and doesn't crash in that case. Hence caller can
> > > > safely ignore the errors that occur during the creation of debugfs nodes.
> > > 
> > > First of all which issue do you have? Did you see that folder is not created?
> > 
> > 	I have not seen any issue as such. But going by the comments before
> > 	the debugfs_create_dir API (https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L583),
> > 	we can ignore safely ignore the return value from this API.
> > 
> > > 
> > > I am not quite sure if this is the right behavior.
> > > In the code there is
> > > 135         if (!parent)
> > > 136                 parent = edac_debugfs;
> > > 
> > > It means you are right that if creating ocm folder can fail and properties
> > > will be still created under edac_debugfs but is this the right behavior?
> > > 
> > > altera_edac/armada_xp_edac/i10nm/i5100/igen6/others are checking return
> > > value that's why I can't see any reason to remove this checking from one
> > > driver.
> > > 
> > > If you want to fix all please send patch for all but I don't think it will
> > > improve situation and it will just hide different issue if creating folder
> > > fails.
> > 
> > 	Understood your point. Are you suggesting that we should keep these
> > 	checks as it is, or should I fix for all the drivers and upload the
> > 	patch ?
> 
> Up to Boris to decide but I would say keep it as is. Even debugfs is not
> stable interface I would like to be informed if something fails. But just
> 2c.

	Thanks you Michal. I'll wait for the reply from Boris.

> 
> Thanks,
> Michal
> 
> 
> 

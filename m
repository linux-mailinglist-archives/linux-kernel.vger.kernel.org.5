Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471807CC571
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjJQOCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbjJQOCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:02:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EF7FC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:02:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9e072472bso35039095ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697551324; x=1698156124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mf0Hwm/v3vvhD6CROPYUWDbtris9frx708TKPgnvJOs=;
        b=nXpbTKYZueIe+5SVDcPh4OwIk/l4PoGTIdw5MNWJAnWJNOv5uRbo9X1daoQBicVzgR
         5J7qWfeTHfjcqltH8dkQP4x6LFBbEePYYN1txgij5FrfBxVrWytGcRdatanRLouRTPP6
         kqMeoGxFYCF99IsnauZsa82nSkOrBXpFKa8CkeMz4JcnX5mBl11S0twD7oxvTdjTfzHb
         rKN9OfgOTmU3ME5DgTfbCwM+/oF8uIT0HHTvtF2gIfkAhwBq1dqxuh+7TgErjI0afxvK
         VZ0G2Q+OeexmTCbOStqFhU+4KaqKQI33WZNFPQXvLhQmYdOw8eIOfH66QEj7l4yRX0U6
         xy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551324; x=1698156124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf0Hwm/v3vvhD6CROPYUWDbtris9frx708TKPgnvJOs=;
        b=gjuA+pE3YbjBRlKaHMxHIX41kqksqLaKVc+Rgc031McrvhPbDep866bnsPAILJSHu1
         Td/0JkxWeWyehkT/Qsa7OJo1KnuWsR1KRSfw392FYuRTGEXygtZ4yW8gy1xH8MKW4OPG
         86C5szZc6c4ffMe3cbV8IL3rn/+r7UtF2+Hr9L5rrwOQ6oFKKtGKa1+64l64pEamqwyB
         dvl7ayVbYbU3DW1EPkZDjPilGW0+4mO2jprDvKleIqnL80DdVQY6uDCEFyd/1naGeqZH
         oPhJdGhKIK/u+9ycejucapY8ScuZTRvG7NyS32zq98JjTfmGrgYc4/Y+mHKTpvKi1SS/
         0lRg==
X-Gm-Message-State: AOJu0YxD7tv9v/vePQKs0Bh51hqxrVbyajPkiUsqXS8TYKPdw4h7Ds3L
        zV1nMK43aVX57Lr9hVza+CSWM+tJOiI=
X-Google-Smtp-Source: AGHT+IGCwru0RlhZVcPNWUZn1I8duRmLcM9uC1HppVLkK9RrRBntW0F5COVkjQx8BVDvu8W+GoaioA==
X-Received: by 2002:a17:902:e9c5:b0:1c9:ff46:1633 with SMTP id 5-20020a170902e9c500b001c9ff461633mr2240584plk.42.1697551324361;
        Tue, 17 Oct 2023 07:02:04 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001c74876f032sm1575146plg.162.2023.10.17.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:02:04 -0700 (PDT)
Date:   Tue, 17 Oct 2023 07:02:00 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <20231017140200.GA3156@ubuntu>
References: <20231016201154.GA14625@ubuntu>
 <433b9d45-bb21-49eb-8062-c03bcffa90ff@kadam.mountain>
 <a45368a0-6f7c-4401-804d-1ff3cb8803b7@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a45368a0-6f7c-4401-804d-1ff3cb8803b7@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 07:06:02AM +0300, Dan Carpenter wrote:
> Btw, eventually if we fix enough checkpatch warnings, then eventually we
> get to a point where all the remaining warnings are wrong.  Like we've
> fixed everything checkpatch gets correct and only wrong things are left.
> So just be aware of that, that sometimes everything checkpatch suggests
> is wrong.
> 
> regards,
> dan carpenter
> 

Thanks for the feedback dan.

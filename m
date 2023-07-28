Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE53276787B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjG1W2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjG1W2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:28:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246C244AE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:27:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686f8614ce5so2074844b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690583276; x=1691188076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJmViVfbJZUOpaWkYQlb1HyRIrlESu4/YkhPXSNwKsQ=;
        b=McOZgZ74ohW0/ytI/ozqvAksmQPGak6eT0bnaaA5NqAyrw3LSSp0phNcnaFF/0Ah46
         QMZYwXCEpqAB62l5ILwh9muOvuGXO/H1d64CM3P2HxD5Mjjnk3i56zZYj6Zab1vRJ0yF
         4YCyVIiBTkbLvuFqbilhV4oFyeABU4gK89esU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690583276; x=1691188076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJmViVfbJZUOpaWkYQlb1HyRIrlESu4/YkhPXSNwKsQ=;
        b=CfVN6zlROxaIi7yhghSJJvdvl3fKJLHnrfIXd3bryp47/AQeHY5q7YC8FUs1JXrnfH
         6ZRBeFUSWAgjfWs0GoxgKVLfiUCfwDLi2azCHQVpEvlUzbGLXP5F7l4tm9lg8Af3+ReJ
         GvtdKnunO9wZEgvVe64rt2iAUmux4Z5V1JvBiIXVsaVX2wdFm3Ck13v3Kak49UZbqDkD
         Vi6mu8FXP2ZC5ZHrqcjWcnCw8bYP4tNx2/on8bTI9cv1k+JCAtM/reF+TuYjByFeuat7
         Ef30O2G4AdcC7xmZa7ii9LVQV2peH7+sPIB2d5UuCaYtAGtrpCIeJ43gjG7pQEa3quzj
         VwPg==
X-Gm-Message-State: ABy/qLapo/eMPosnSxF6ERwQWrmYXLOo3UTZWJdnq561ZKFLADhyBDdp
        SdIzjac5vueBOBwK/B1yOOl4Gw==
X-Google-Smtp-Source: APBJJlHHaeaPYUzn1UHI4kQ1cMg3BcZGonEinkrtEn+Ei6954g/2BpXZaVmrmzEY2GOJiqqmwbd0Zg==
X-Received: by 2002:a05:6a20:2c98:b0:137:8599:691e with SMTP id g24-20020a056a202c9800b001378599691emr3050596pzj.49.1690583276613;
        Fri, 28 Jul 2023 15:27:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b0064fde7ae1ffsm3647960pfa.38.2023.07.28.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:27:56 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:27:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Seo <james@equiv.tech>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] scsi: mpt3sas: Fix typo of "TRIGGER"
Message-ID: <202307281527.300679B747@keescook>
References: <20230725161331.27481-1-james@equiv.tech>
 <20230725161331.27481-6-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725161331.27481-6-james@equiv.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:13:30AM -0700, James Seo wrote:
> Change "TIGGER" to "TRIGGER" in struct names and typedefs.
> 
> Signed-off-by: James Seo <james@equiv.tech>

LoL. Yup.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

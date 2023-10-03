Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3E7B6773
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbjJCLNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbjJCLNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:13:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD71AE;
        Tue,  3 Oct 2023 04:13:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so1374409a12.0;
        Tue, 03 Oct 2023 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696331598; x=1696936398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3luBE338An7uOAk1OcMGKWBZ5Pr4mpK2fSSvbg0/GeI=;
        b=FNWCkj8U/ozz1LPvm931aoFp4WDaDJw4UPG85WorGF55+CbITOH54mYQjUa2EyUvPD
         P+1cNhHPeGCUHdxLvThl0Ux5wuB36B3rlqTVEqhjUe7kIHGm5IxhMdpo8rSWNMAqFI1S
         46eU88i0O4nqrH0GXVRdeoEIQSILl94iSLeiTbVDTSqqMvBwynM+w7F55rzSRri2FV/e
         HWBVeV3WZuIBmsmN23RjhPU2ZEbz/YjRiMz61Cl5FUO3UvblCCLU3bE5EEz6kCSKz/yB
         qFQ56wcS+ttS3RQ2oyAiat9aWWipVklXNhCZnbSQjlnEKkByRg9+mtJY5cIU/XznP/e1
         7CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331598; x=1696936398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3luBE338An7uOAk1OcMGKWBZ5Pr4mpK2fSSvbg0/GeI=;
        b=FFEn/n4vgIJnGu4XplSmH1NRYq5JQGCsraFWi9/pANrejHY++SgLt/dWEDIFGWHfjs
         ag9pIBiGNbEfmyNJYdNsjbWcAQ0+3wRwEk8ZVHA29MEzU21bYwVBqIPnuOxfwijUG+xy
         UPawjfDv+Ez/jzPhSts1vzohUZqmjjGNQ/IvhcAhInXETP/3hNt54/gAzpIvakFfYf7Q
         zNye/6OgTEZMWRh6O7szRDgIMEGI0MLV6CmfvqJ0tWcgn4wIqLIGUkYl/3UxhfZt3pmG
         WN62RWZE4EtSacSSIlaKumqQgOjKQhqKr3DrgYlCO+7NcDOtpPiJDazZctiLpZm7Jamw
         xhiA==
X-Gm-Message-State: AOJu0YwA5/LSg1DErCNUJUPph2kXF+p5Lv4nb1M9pyowpi4GqAiRm6SN
        O9Ck0NhODa7DntdxtkEb8OI=
X-Google-Smtp-Source: AGHT+IFeDp0mkXJrBV8uMZLCnlL2zxKWcJdDm1Xibz4bWonczwbYahjEkyal9T7Iwjo5D+2KDydyew==
X-Received: by 2002:aa7:cf92:0:b0:531:2b7c:513a with SMTP id z18-20020aa7cf92000000b005312b7c513amr11412427edx.17.1696331597567;
        Tue, 03 Oct 2023 04:13:17 -0700 (PDT)
Received: from primary ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7da06000000b005346bebc2a5sm698603eds.86.2023.10.03.04.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:13:17 -0700 (PDT)
Date:   Tue, 3 Oct 2023 07:13:13 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 06/14] USB: typec: tps6598x: Clear dead battery flag
Message-ID: <ZRv3SRwZ9hbtA3ka@primary>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-7-alkuor@gmail.com>
 <ZRuuvj3r1kBqc+EI@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRuuvj3r1kBqc+EI@kuha.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:03:42AM +0300, Heikki Krogerus wrote:
> On Sun, Oct 01, 2023 at 04:11:26AM -0400, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > Dead battery flag must be cleared after switching tps25750 to APP mode
> > so the PD controller becomes fully functional.
> > 
> > Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> I'm sorry I noticed these so late, but this one really feels like it
> should be part of the patch 4/14. Is there some reason why you do this
> separately?
>
That's a good. There is no actual reason, it was just simply part of the
implementation flow. I will move it to be part the patch that supports
tps25750 implementation

Thanks,
Abdel
> Br,
> 
> -- 
> heikki

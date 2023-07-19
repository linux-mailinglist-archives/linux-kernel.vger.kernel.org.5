Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15D2759D85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGSShb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjGSShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:37:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E511C172E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:37:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so67544325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689791843; x=1692383843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wbzW658ot9d77mkw3ofuoH8LwLVnB+5s2Ey2zvsPMLA=;
        b=L2PGvrwI327GW5ln8uaCIDaHaJwt03XsUEF27j+7GuR690LN+uF0XU/ie3PTyqj0UL
         QSA3b+YYjWHJDTRxAMvm6GoFfREPV9pRn2+dtm/NELtJnK4XlEAp010kdPmvUoG5jL9P
         64rQc7pYOSEZ1jpvQwfEqCy4mr0G0UlOk5rXIxNigGRBBU0vNVFabQcJs1O2sAPy/cu+
         wtMF6O3xTRahupfRWnDUMAIcb9Gqx4ag8c9n3x0QFyhHE3YyL7pSkvPOb6pCzBzZhcLW
         cNBkYapGO4+d83y55R59ihHoUAjISxCtyrZhv643/3neDAsBgng+ezrbHLJqlf0FbhSC
         N3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791843; x=1692383843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbzW658ot9d77mkw3ofuoH8LwLVnB+5s2Ey2zvsPMLA=;
        b=F21/OJYmB4j+oKaqGge0ZrLr/FvemUIVCUU3dwHOXJtxulI3WqtUSCI09n3+50hj8a
         ZWlVCSPy86NXY3l8ctEIWuQbWoIFY+75mVcXiGvh8EMxWSRxY7XmOEU3vUIvzWCfy8K3
         bsS7Ci0ZvSmlngCRl5r9A1X7fmj7CvWRACrWjNupO51crSc6dLfLNunghGTx7MSoOSdq
         i4NhM0gPb9Vy2VLULvRpKZTsvOIgrZGQdTnU7++HQf+T7TrY1TAftpuZuRFdL/Dd0GLW
         UWWnwRT44xWSULB+NyxSfvn9DuOam9pUiZpoUGHYvhsrNZZemoP474xGvGBM7t6HKOWb
         +PQA==
X-Gm-Message-State: ABy/qLZN1clE7SbsisNm9R+EG/q0xWVSOUU/hF0k14IOLaaB8vHoeudI
        a7fhfDym3xDbjM+xQcWemg+0vKD14e9o3cyHFcs=
X-Google-Smtp-Source: APBJJlGKJGSZ9wWN5QqDTFFlth9Ohf7bjuHUGOgd13rN/5JzESpmy06zg5Pd4gE36DsRje6KDHHWCWpDeVZxYJd7pJ4=
X-Received: by 2002:a05:6000:ce:b0:317:1911:fd7a with SMTP id
 q14-20020a05600000ce00b003171911fd7amr531921wrx.12.1689791843281; Wed, 19 Jul
 2023 11:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230627152449.36093-1-dg573847474@gmail.com> <ZJwd0UDKYcK9AvSf@mail.minyard.net>
 <9691d898-22a9-4902-871d-73f5dafabf86@app.fastmail.com> <ZKQsY3DXXDbxy0om@mail.minyard.net>
 <34c75a2f-2daa-49be-bdca-a3fff5ed5a4a@app.fastmail.com>
In-Reply-To: <34c75a2f-2daa-49be-bdca-a3fff5ed5a4a@app.fastmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 20 Jul 2023 02:37:12 +0800
Message-ID: <CAAo+4rXkVJ0WJM8Mrd35eUEnJC71Jzs2eff_J0Y5EEShybbd6g@mail.gmail.com>
Subject: Re: [PATCH] ipmi: fix potential deadlock on &kcs_bmc->lock
To:     Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Tested-by: Andrew Jeffery <andrew@aj.id.au>

Thanks much for your time and effort in reviewing/testing the patch.

Best Regards,
Chengfeng

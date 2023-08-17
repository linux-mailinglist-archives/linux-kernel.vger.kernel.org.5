Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F96F77F1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbjHQIPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348789AbjHQIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:14:39 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064DF2112
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:14:38 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40c72caec5cso231341cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692260077; x=1692864877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRlDliIp3CGp2aSiQsIM0n5hPxeNnC38brktFJUoztg=;
        b=yFFOD2no4UjmvtOd1f+wwkgPxqUaCE26RgD7vxGeBht5FMVUU5XtfBIMMBC6A2kIhM
         0BPJv5bEnRBm1YX0YA93bRliuuIov2VoYuswWYzUvTZigErPnCI3WMCnBdopai3QlYAe
         fFVD5RYL8z0wNqhkuf/0oFjHAGcpFrLlNdp8EN7ht7mlMp3SLOILvFGrqYA0gauFmUC5
         dnPlZhFEsJvSWWaXXdH/jSpddEltQxxXmqK4dyre31akS1hIt0YQtiM6cNVC+Ob8II8g
         5vLvrLLn8cysJMiDlnnWRdD4CLcRJ0J+mm6HE1aXOjDRmbxVjWNjgVS1D5pXJoZPunPr
         rL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260077; x=1692864877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRlDliIp3CGp2aSiQsIM0n5hPxeNnC38brktFJUoztg=;
        b=LKMMWVBP2G/Hl1X/i1lgsYv/gNP/dNy9hd/aLhkBC2CHUCf1gFouXZGQp0TUoC8X9R
         GDXHLJs3WW3TXoLpBkmJ0+BG8Hs1+WDY3wzNl4Zw1LgjNzu5suKdmwN0ARrCkStCAk3/
         bzJ75YXzCcyyU+UmQGy0DC2bPb2A7m1toICQcYC4ax2PXAogpl8R26EybX1SaGX90tOe
         L3AJRas7A/WFFzC/GjmgErXT5SVBnSIHD8wwhxJeprpMfOtcdaIlVyEnsDi2qUvIjL21
         z2hs5LzhgSMub0IXCw7qV2C8h3yn1jxvdZZ/cUJ6lClExHK8ZYYMOR8ZeU8DDxg1i/qG
         igSw==
X-Gm-Message-State: AOJu0YzfNcQGhUYlRPH++I708+cwH6J5a4cbaLLYeHqpvAKtU0FAU2DN
        Mh463NQNdOz0LX7PuJOSmdx9Q7koKy/QToqGSIcWWa/YFbMCuSZAarlb4g==
X-Google-Smtp-Source: AGHT+IEIEAVGK3aCwKeWT5dAbNi9pux/aA6pVy+iWD5WQ8+wNBWHQJOf0yq1XFSRgXWeV2VR/bnTZjP2+mw3n2IzAWI=
X-Received: by 2002:a05:622a:f:b0:403:affb:3c03 with SMTP id
 x15-20020a05622a000f00b00403affb3c03mr212303qtw.10.1692260076914; Thu, 17 Aug
 2023 01:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com> <20230816211849.v6.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <ZN1fW5CmgbxGTrmb@Asurada-Nvidia>
In-Reply-To: <ZN1fW5CmgbxGTrmb@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 17 Aug 2023 16:14:01 +0800
Message-ID: <CAKHBV24-ZKS53tdKW7J8kV1br2pKgdEe4EkhRU0Nx+Zsks7CbQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 7:44=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> On Wed, Aug 16, 2023 at 09:18:46PM +0800, Michael Shavit wrote:
>
> > Also add the device to the devices list before writing the CD to the
> > table so that SVA is always aware of all the CD tables that need
> > re-writing when it updates a CD.
>
> Can you please elaborate this a bit more?

Yeah I can update the message. Something like:

Also add the device to the devices list before writing the CD to the
table so that SVA will know that the CD needs to be re-written to this
device's CD table as well if it decides to update the CD's ASID
concurrently with this function.

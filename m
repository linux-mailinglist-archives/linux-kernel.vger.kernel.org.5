Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7274876E55D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjHCKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjHCKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:16:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59633AA4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:16:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40a47e8e38dso195261cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057762; x=1691662562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOr42OTiqwuGgbJm6LEEziFOJyncUa+T/gr4vCNaqGY=;
        b=ceF0aZ1kYRIaCjRP0tTmmcv9Jhn3nKp2gYfVyWfgiTdf1RNanXYgBWp8FEiGOjhcm1
         LfwFPktlPXciFzr01X1Q5xcbAlWhYLsI6rMJCvi9ccMJVdLSoXgGdFAL/LPEN++JCD7X
         Uek/nqFOe+Bl+dSQ54ncOhCUo4B9r/KH3Gx58AGZHZ7lr+150oqpMgSJ+YpCopoYcb4j
         C9IfDSzrJ+rQqSrz7tCS3bIS7IWW+ZRmIH5tP17FhkVOYIrU8H2FzBaYD4UtGPB8pYzZ
         OSVX6FP/C9CYaCeEzj+CVy6hPOOc1AyaAAO9wM9Hhpd2Ju2tW/QCE7hFFK5qc8YbLvYX
         u/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057762; x=1691662562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOr42OTiqwuGgbJm6LEEziFOJyncUa+T/gr4vCNaqGY=;
        b=MHFLjjALKLPO7UXqWYSXP0QASGtxaq1G3lI4OitCfDUFDg77+Fq0CqqpXDcKowPQws
         TbVw72ru9F2qdIF8dM9kZKNVlMnlhv2PU+gAnQuxWb2VDcpkTnD+cKBPLVZvDs+tArGy
         aOet5xrQdqR316TBcoldUThm5B6sQnojCUW8plXNso18qzyFXgSFzUIHV81uwJKxKHkm
         mO26zh35NIdxByn4+fjGjlsiu/eOV/9poqSILuf4h2KhAsDX0xE0grQAKIJlwU1WjfK9
         R+4vo4cnElSKQwH0NzNJcmHT8V0rudaCwQhEV4V6wC/F9EeqL8Ubcy50joKrxLSrk67S
         sJCA==
X-Gm-Message-State: ABy/qLbB3flBPMWlhJfxl43MifmShtmo9I6ovVSGj/WWN8Az5pQyKQbX
        zSIOcjs9ZnKawJo5g+6umA/oY1cGLrDJjH0LS0DYNw==
X-Google-Smtp-Source: APBJJlGwUqTyg1oUt5euBh0ut1AeSopxrW/THLJ12+7fGBSLProZNbKZm/LOkBs7PJ1rjxVr7w2pnIqRnnJfjYccDuI=
X-Received: by 2002:a05:622a:1aa2:b0:405:3a65:b3d6 with SMTP id
 s34-20020a05622a1aa200b004053a65b3d6mr1207827qtc.13.1691057761676; Thu, 03
 Aug 2023 03:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com> <20230803181225.v5.6.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
In-Reply-To: <20230803181225.v5.6.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 3 Aug 2023 18:15:25 +0800
Message-ID: <CAKHBV27-fkATKL9OyVgSG4M2vxvT0AyUVFqiwqpV2RUu1OArxA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com,
        jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 6:14=E2=80=AFPM Michael Shavit <mshavit@google.com> =
wrote:
>
> Remove unused master parameter now that the CD table is allocated
> elsewhere.

This almost certainly belongs in the CD table patch series. I'd like
to move it there if this commit looks OK.

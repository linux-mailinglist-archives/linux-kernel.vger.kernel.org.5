Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B18F76AA71
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjHAIBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjHAIBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:01:21 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C8198D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:01:20 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40c72caec5cso223621cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690876879; x=1691481679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwyr19S0TCJZ5VuRNPaLImVIGikcLg8N0JXke6/SZ1Q=;
        b=TpIV2fBhjggI66wGECsWZWeQ/ITLWwvObDTn0TOXgtXaOwsaIwcvUx3CRPZBz9C4XI
         mEAVcn632crZhGSjgl4yAV8HGSEJn3M4V4A5bUqJDmVCdWZDE0nBxjlqqKYgb6c8QnGQ
         qsmlTaxME7oKUowgbnEX9VF/cP797ZrXOyeExljKsJ9yI9SZho7Za4BR+l0dFrdRuUXf
         bFj/Vy4i3AQn8+P7IzImbZ7Z9oPUgD5BHIpgJxlJs12bI28IyrgJAUSbu3OQ08ebHpXp
         94O/+zQxuo47SkaZtti722A3uDu40DdkETYphXqrfUhL4cNit8o6N84aiS0dNYi6lCgO
         thvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690876879; x=1691481679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwyr19S0TCJZ5VuRNPaLImVIGikcLg8N0JXke6/SZ1Q=;
        b=YEEH9m2pLb1ajOMEUDeDwta+FXtWpI7yvIeNKrqivBUG6hGA1hEtWB67PXKYcIJgzX
         YMUUiupAS+eOF9arIDsMSbu2WkhCFZAFgCxFA4ICYkq8RVRBvPg1+qvhNz1mm1wPWDIE
         KSV0dqpBaXBkTkek1sBpY/PThjrFBNEuVd27TUfjouHTO6Q4NiiZtJaKpjOWSF3XyJmE
         Lnk1EmahkqsSfr5xGxDfPiYn87IOB1OjExoSLnsFqwdpdRtlu7kV0jC+QeRA8Fdcj4p9
         uZeM0JGjXLbhyq6kmqWYQelh+4qU6iP2Mt7cseAvBBMt5RpfOxZRGBmaCFNq0GE7dfTp
         iepA==
X-Gm-Message-State: ABy/qLYVYR5im9EDo/U5B8xjHqzY2lOnf5/N69MOB+abEuyIkZMFz6gt
        CpeRbzuoMxPFNCOQRDj2x+dtnuKlgCcMebpY4/6R5Q==
X-Google-Smtp-Source: APBJJlGbJiCGi2WbzNRkqn+UGG9iYkhXZLgCWzz0KD+IVaAUeE8KywhNcy+qIOAh1L8FgvI0JPmRabMsYQzNkljIiYY=
X-Received: by 2002:a05:622a:1447:b0:3f4:f0fd:fe7e with SMTP id
 v7-20020a05622a144700b003f4f0fdfe7emr597315qtx.3.1690876879525; Tue, 01 Aug
 2023 01:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com> <20230731184817.v2.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <ZMiGs5dR6IKF855y@Asurada-Nvidia>
In-Reply-To: <ZMiGs5dR6IKF855y@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 1 Aug 2023 16:00:43 +0800
Message-ID: <CAKHBV27cemBkU9e-=UMNizwnEjWScEK1bNzy8O_X7K55Da0aCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 12:15=E2=80=AFPM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> On Mon, Jul 31, 2023 at 06:48:12PM +0800, Michael Shavit wrote:
>
> > arm_smmu_ctx_desc_cfg is renamed to arm_smmu_cdtab_cfg to make it more
>
> There seems to be no change of renaming "arm_smmu_ctx_desc_cfg" to
> "arm_smmu_cdtab_cfg". Even PATCH-8 only renames the local variable
> "cdcfg" to "cd_table". Also, we should not use PATCH-8 to justify
> this change, because it makes this patch less convincing since the
> PATCH-8 might not get applied at all.

Oof sorry for the mixup. I made the change described in the changelog
but then undid it based on the last few messages of the last thread.
This commit is identical to the v1 change where cdcfg is only renamed
to cd_table in places that we touch.
Will fix the message.



>
> > obvious that it represents a cd table. The max number of CDs that can b=
e
> > represented by the CD table is stored in this truct in its log2 form
> > since it is more useful for users of the CD table, and replaces the
> > s1cdmax field in s1_cfg. Instead of storing s1_cfg.s1fmt, it can also b=
e
> > trivially computed from the cdtab_cfg, and is therefore removed from
> > s1_cfg.
>
> The commit message does not quite well describe why "replace s1_cfg
> with cd_table" in the subject. It could mention that the goal here
> is to move cdtab to the master structure. And "unwrap s1_cfg" might
> be more fitting in the subject, IMHO.
>
> Thanks
> Nicolin

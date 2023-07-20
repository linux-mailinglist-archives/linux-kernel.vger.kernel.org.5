Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0904E75B5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGTRrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGTRrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:47:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B321268F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:47:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so776519a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689875272; x=1690480072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeRtmaYTAPyRY4aCeM38ToCVz+RzHutrGkJCqmGIdOc=;
        b=VN4kSEn7Ij6Jb7Boit8qxzz8hu77UOlfTYQHpith3ypcF9dbr8xWuknkAmP8IvhxBt
         LSx9B51i2TsdB+RUriiJWHvSRCwVRBNb/OI0bv4fZ/ddJi9e7EqZDdUFRo7TczeEC+of
         URUI2buBPQWpMuUbL5yFNjv3VfjFHoK6KfHtE3V0FBlLSVS1/fJkaVvbpoFsooaHkONk
         IiFE6+Rr2ppLX1fM4YPj6b3txnVsbIyOeLireIiBSPXqxXZkVMydnEz+QuohTe2sTnjg
         S5IjI4CkxDg5Hq6JKbejvTXX4S9QbaToU/WxyTcuWJ+ESMkC7DDIWj4BZafziobkSX7k
         soOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689875272; x=1690480072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeRtmaYTAPyRY4aCeM38ToCVz+RzHutrGkJCqmGIdOc=;
        b=cH+2tYL8SMYBubrT+KHdA+D6wxbzj6FmthnpmCuAYzaHay8DX4AghHML3xBa91NapM
         3wuEEixjGt5XjhBARVoFAIGKj8W2qb/errCyuXYzyQmurDBO7QSZatucTA9PSgPIJAFl
         rllkGvU7ElIPuaLwvGnuGX3kkM7UIlppWJAFdV83IQaa6b/Sxm8lwZn0lbWnLHEqXk0X
         Qbv4EyTxhgxRqYGRHg6ZST84PWnApl3z9BHJgwVPUx/weM1eWouRMuJyWoprKEpXTfjz
         AmndRi+4NsQorKpxdhPxxdFvX045AgQ3a7znT3TcpS7F4SydhpVMCXCMytVvNY4sfmvS
         /YTA==
X-Gm-Message-State: ABy/qLYmSzGwrCu9O5kWwzdnLoMpmLjp+hj6encH5mK2AgxIs5MI02Rw
        C5YEtgp/zgs11GCMMLLS4ttDz0fKFbLM4tj6ypJp+w==
X-Google-Smtp-Source: APBJJlHy5UEy2yIQNNS3I4ewj2XdSdHRI6Php31TNjCHwslBISu4YslmtmapMSbRvm/h863Rb7ly70c0/Q+NZJYe7/k=
X-Received: by 2002:a17:90a:8b81:b0:256:675f:1d49 with SMTP id
 z1-20020a17090a8b8100b00256675f1d49mr120295pjn.0.1689875271671; Thu, 20 Jul
 2023 10:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
 <2556751a-c439-bb69-a102-583dd985fc5e@linux.intel.com>
In-Reply-To: <2556751a-c439-bb69-a102-583dd985fc5e@linux.intel.com>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Thu, 20 Jul 2023 10:47:40 -0700
Message-ID: <CAH2o1u7WO=Kpki1qMGoq3uJ2vVqhCvffvX0hLGc7o9op2vTCbw@mail.gmail.com>
Subject: Re: [PATCH 05/11] RISC-V: drivers/iommu/riscv: Add sysfs interface
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 5:51=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2023/7/20 3:33, Tomasz Jeznach wrote:
> > +#define sysfs_dev_to_iommu(dev) \
> > +     container_of(dev_get_drvdata(dev), struct riscv_iommu_device, iom=
mu)
> > +
> > +static ssize_t address_show(struct device *dev,
> > +                         struct device_attribute *attr, char *buf)
> > +{
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);
> > +     return sprintf(buf, "%llx\n", iommu->reg_phys);
>
> Use sysfs_emit() please.
>

ack. Thanks, will update.

> > +}
> > +
> > +static DEVICE_ATTR_RO(address);
> > +
> > +#define ATTR_RD_REG32(name, offset)                                  \
> > +     ssize_t reg_ ## name ## _show(struct device *dev,               \
> > +                     struct device_attribute *attr, char *buf)       \
> > +{                                                                    \
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);    =
 \
> > +     return sprintf(buf, "0x%x\n",                                   \
> > +                     riscv_iommu_readl(iommu, offset));              \
> > +}
> > +
> > +#define ATTR_RD_REG64(name, offset)                                  \
> > +     ssize_t reg_ ## name ## _show(struct device *dev,               \
> > +                     struct device_attribute *attr, char *buf)       \
> > +{                                                                    \
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);    =
 \
> > +     return sprintf(buf, "0x%llx\n",                                 \
> > +                     riscv_iommu_readq(iommu, offset));              \
> > +}
> > +
> > +#define ATTR_WR_REG32(name, offset)                                  \
> > +     ssize_t reg_ ## name ## _store(struct device *dev,              \
> > +                     struct device_attribute *attr,                  \
> > +                     const char *buf, size_t len)                    \
> > +{                                                                    \
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);    =
 \
> > +     unsigned long val;                                              \
> > +     int ret;                                                        \
> > +     ret =3D kstrtoul(buf, 0, &val);                                  =
 \
> > +     if (ret)                                                        \
> > +             return ret;                                             \
> > +     riscv_iommu_writel(iommu, offset, val);                         \
> > +     return len;                                                     \
> > +}
> > +
> > +#define ATTR_WR_REG64(name, offset)                                  \
> > +     ssize_t reg_ ## name ## _store(struct device *dev,              \
> > +                     struct device_attribute *attr,                  \
> > +                     const char *buf, size_t len)                    \
> > +{                                                                    \
> > +     struct riscv_iommu_device *iommu =3D sysfs_dev_to_iommu(dev);    =
 \
> > +     unsigned long long val;                                         \
> > +     int ret;                                                        \
> > +     ret =3D kstrtoull(buf, 0, &val);                                 =
 \
> > +     if (ret)                                                        \
> > +             return ret;                                             \
> > +     riscv_iommu_writeq(iommu, offset, val);                         \
> > +     return len;                                                     \
> > +}
>
> So this allows users to change the registers through sysfs? How does
> it synchronize with the iommu driver?
>

The only writable registers are for debug interface and performance
monitoring counters, without any synchronization requirements between
user / driver.  In follow up patch series performance counters will be
also removed from sysfs, replaced by integration with perfmon
subsystem. The only remaining will be a debug access, providing user
access to address translation, in short it provides an interface to
query SPA based on provided IOVA/RID/PASID. There was a discussion in
RVI IOMMU TG forum if it's acceptable to expose such an interface to
the privileged user, and the conclusion was that it's very likely not
exposing more info than privileged users already are able to acquire
by looking at in-memory data structures.

Read-only registers are to provide debug access to track queue
head/tail pointers and interrupt states.

> Best regards,
> baolu

regards,
- Tomasz

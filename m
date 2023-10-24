Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC727D4CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjJXJsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjJXJsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:48:42 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A7F9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:48:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77784edc2edso267731085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698140920; x=1698745720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQvE7d2b7lAwzpOL0YoL6j9XfcidTFdyaezbY3znHc0=;
        b=m29UYdaXShw6JwP/bSpeywGyhSiAjRwiKTQBqapTJz6XKcmgb6vnAIDEx+qc4tceO0
         32wHdJFPWrPQrjhnSih6TkfRWZmmrG1jIDY5dfw3vSbYuzSfO3RLOu9T3k7Zx+PTRZL2
         og5B5rRUPeCLCd3O84ptzKWCE/ylT771+hoiPA+KIG8JAVNy3GxqN+czOkHIQOiq+ZQ1
         W+lQ4lHo1o2gAnVuAKVuEK1zs+bpeVWDJKIqR5wSLlr2momeGtQpLRC/WZ/1GWB2THy0
         pb2mwEJNrTXEnZs2sZiXKO9DeebTw0nJoSS0YwkBMXsZlLcUawoT+mPYeVQO3s8cxi4u
         11JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698140920; x=1698745720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQvE7d2b7lAwzpOL0YoL6j9XfcidTFdyaezbY3znHc0=;
        b=wqkEAH/zbrX/QU1e1zmVye0AH0QYUrBc48QQ1MXuJHto6RbRQU4P42BkhCyWNGxJSM
         Zh+MP+dGCsFtfKLZQpm3A949c/jQlK5hSVML1LFrp7P3shdYLYw+HlUbrFHxk3yGHCsO
         2pcd6VG/dl2sRJPbf0TgiAU1IJjx2sZX4fElJZXpBu49sQjbFRK8OWlzIqbSSuQsDzzq
         9kEQ7drPT83FbRb+V+IK0c6YWgYOHqXXCvxiN3IDOVglxf7zkD0Xp+WWxwrbHih1SGEy
         mxtfe1TzeIG7oZ+PyoKOqNoJObJGWyd+9nXXs6TfGvoQop7jx88+0HPD1D4QQTaKbMzn
         tsMw==
X-Gm-Message-State: AOJu0YylTb89iz3DVplonAaX9eG0Q/2izWJ/EiLWA5IUPye34j+LG9aq
        lumZsrzRmI4EIMWqFhF7JmWKt+iDjLzEG0+w0zPGZ83+4Hg=
X-Google-Smtp-Source: AGHT+IFcgRR6qHlM9QXH1zEYR+OdFHh9sebeZzt54eXkQzlMTuLkEyVljloG9krVf4oSYlpFuWdGDuXH8lGlzEsDd+U=
X-Received: by 2002:a05:620a:2a11:b0:779:e517:f425 with SMTP id
 o17-20020a05620a2a1100b00779e517f425mr3850048qkp.20.1698140919569; Tue, 24
 Oct 2023 02:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231023103852.28743-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231023103852.28743-1-m.muzzammilashraf@gmail.com>
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Date:   Tue, 24 Oct 2023 14:48:28 +0500
Message-ID: <CAJHePoZzMagaTLdRqmisgKx5arvm_YujyefzeCku1=ETPHWLVw@mail.gmail.com>
Subject: Re: [PATCH] include: uapi: linux: iommufd.h: fixed kernel-doc warnings
To:     jgg@ziepe.ca, kevin.tian@intel.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Can anyone review and approve this patch?

On Mon, Oct 23, 2023 at 3:39=E2=80=AFPM Muhammad Muzammil
<m.muzzammilashraf@gmail.com> wrote:
>
> Fixed multiple kernel-docs warnings
>
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> ---
>  include/uapi/linux/iommufd.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 50f98f01fe10..2211f1b53d6e 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -419,7 +419,7 @@ enum iommu_hw_info_type {
>  };
>
>  /**
> - * enum iommufd_hw_info_capabilities
> + * enum iommufd_hw_capabilities
>   * @IOMMU_HW_CAP_DIRTY_TRACKING: IOMMU hardware support for dirty tracki=
ng
>   *                               If available, it means the following AP=
Is
>   *                               are supported:
> @@ -486,6 +486,7 @@ enum iommufd_hwpt_set_dirty_tracking_flags {
>   * @size: sizeof(struct iommu_hwpt_set_dirty_tracking)
>   * @flags: Combination of enum iommufd_hwpt_set_dirty_tracking_flags
>   * @hwpt_id: HW pagetable ID that represents the IOMMU domain
> + * @__reserved: Must be 0
>   *
>   * Toggle dirty tracking on an HW pagetable.
>   */
> @@ -499,12 +500,12 @@ struct iommu_hwpt_set_dirty_tracking {
>                                           IOMMUFD_CMD_HWPT_SET_DIRTY_TRAC=
KING)
>
>  /**
> - * enum iommufd_get_dirty_bitmap_flags - Flags for getting dirty bits
> - * @IOMMU_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing=
 any
> - *                                   dirty bits metadata. This flag can =
be
> - *                                   passed in the expectation where the=
 next
> - *                                   operation is an unmap of the same I=
OVA
> - *                                   range.
> + * enum iommufd_hwpt_get_dirty_bitmap_flags - Flags for getting dirty bi=
ts
> + * @IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without cle=
aring any
> + *                                        dirty bits metadata. This flag=
 can be
> + *                                        passed in the expectation wher=
e the next
> + *                                        operation is an unmap of the s=
ame IOVA
> + *                                        range.
>   *
>   */
>  enum iommufd_hwpt_get_dirty_bitmap_flags {
> @@ -521,6 +522,7 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
>   * @page_size: page size granularity of each bit in the bitmap
>   * @data: bitmap where to set the dirty bits. The bitmap bits each
>   *        represent a page_size which you deviate from an arbitrary iova=
.
> + * @__reserved: Must be 0
>   *
>   * Checking a given IOVA is dirty:
>   *
> --
> 2.27.0
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093B37B9FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJEO3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjJEO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:28:12 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA71672A4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:57:38 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65af72cf9e7so3148336d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696489058; x=1697093858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZN88iZNzUh/0bMpjJoHAmMov2SFFx31BRWDglRmz5o=;
        b=u5/AzTTziyhb9qzTux8lqZUvciY2wv5GaTD4CpU9NZOc0/TaKOJiPSQ48rBZYLvUbz
         PwYO7QS125J9V3HvV1/FyVm9X8j8XQnqYxkJc9z6tGr1u67jBglZs55x6rtxxLqf5JQu
         lfx74+kRAvMPB1js6kdoPN16BetgAaLfBlTECeVQXh8RlSZIfHe5kMtlCIaxfPCoUk6N
         hJazDfVZdT3Hr8eZA44djvvTuVxowomQYX58Y4XxnR7B9n4eAPPE1Cs9LBTZNky5gDk8
         5L67GeBQ0gh6kMjmPSigoNV0oH+5x1TcAV/rP/7cRyyn8DlWUTd8cIeR9bM7lFIbBj+0
         6sDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696489058; x=1697093858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZN88iZNzUh/0bMpjJoHAmMov2SFFx31BRWDglRmz5o=;
        b=aVJplnSmxGJ84Zv5I9yOtkUnpmMhomaeTOTDcoeRcSuuMaRgDoskuQUAosJyvSggto
         +7KQnRnp1eYP5djaanUOegg4FqtgIPmPNfnddZ8MGMDdMbHA83G4B3lyCuG0xJVWA+od
         8OuM8ZKvKkHMLxgfkk7U2mMlR4ac+JbuDuUnAfOmSzU2vFEF9+nK4KAft3QEy+KSA5jN
         /ajW6QnCQQyY8aKy6hgjYTJvmCtpDE8fS6RxKv1dXy4xypHuR7PxWvouBZbxlpAGI3JY
         ZdWBGzqcZi5JBYHTKuGywi1I+VG4wJn8J+9FHjOBgDuCM+ZyIPvtDvOaRlGclo1eyX1Y
         Ie6Q==
X-Gm-Message-State: AOJu0YwlfznCbEzA+QFOkiT/ijDil97OlQ+fdCYKXEYnHooMWHmAhUyT
        1Vb2+QlSUPyqSjBMpGD38hTpqSeMCc0xq/b2JaKR9RQn2gEId6nLbXw=
X-Google-Smtp-Source: AGHT+IHs/AnGHUpVp53YzUp9JeBQmrwkm4bRypnJGgwmixBFAjDmUtSGbxNth6rksQhKLuKcM4fOPogzB7V6HU/nXx8=
X-Received: by 2002:a05:6214:5497:b0:65b:32c7:91a with SMTP id
 lg23-20020a056214549700b0065b32c7091amr4283432qvb.37.1696489057988; Wed, 04
 Oct 2023 23:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-3-c8e4f15190c8@arm.com> <20231004091154.GB1091193@rayden>
 <DB9PR08MB67968986584B6EAC87B20C439BCBA@DB9PR08MB6796.eurprd08.prod.outlook.com>
 <20231004153234.ktk6egntk7drao47@bogus>
In-Reply-To: <20231004153234.ktk6egntk7drao47@bogus>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 5 Oct 2023 08:57:26 +0200
Message-ID: <CAHUa44GWA_WQSgOgtQKgawc11vpaD5B4q5rNq8fxnEFJk_NzmA@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Olivier Deprez <Olivier.Deprez@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Bonnici <Marc.Bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Wed, Oct 4, 2023 at 5:32=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Wed, Oct 04, 2023 at 10:50:26AM +0100, Olivier Deprez wrote:
> > Hi Jens,
> >
> > > dst_id and drv_info->vm_id should be swapped.
> >
> > I'm curious about this because swapping like this actually makes hafniu=
m
> > fail. Need to check from the spec.
>
> I did check after I had swapped this in v2(because I was convinced Jens) =
was
> correct and you reported the failure. Reading the spec again the other da=
y,
> I got corrected myself and agreed with Olivier and my original
> implementation(v1) which matches this patch(v3).

I don't get it. The spec says for FFA_NOTIFICATION_BIND:
Sender and Receiver endpoint IDs.
=E2=80=93 Bit[31:16]: Sender endpoint ID.
=E2=80=93 Bit[15:0]: Receiver endpoint ID.
This is exactly the same as for instance FFA_MSG_SEND_DIRECT_REQ.

In ffa_msg_send_direct_req() you assign
src_dst_ids =3D PACK_TARGET_INFO(src_id, dst_id);

but here in ffa_notification_bind_common() you assign
src_dst_ids =3D PACK_TARGET_INFO(dst_id, drv_info->vm_id);

Thanks,
Jens

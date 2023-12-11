Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1465C80DB45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbjLKUIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjLKUIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:08:13 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B6BDB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:08:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so558019966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702325293; x=1702930093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I2A+kU/heU05z60USe87SZbkTbX5b5JkqKjVk3UqXg=;
        b=cF5NBJ3zDm6UtbpRASgd/4nia5UP9rhx1b9ZdES84QqTc0UQtEFk1W4dAoJNLkPkCl
         synJ+ZgNv1DGQccuXsfjUC0WcdJMBqhVB+C4xr6Hz/XlUlduvEk7dPXsC2rz6u5RaJ3/
         CFzOMRWX8+r+ovz8XpDZfs5Gaqr6m/fyUiwazYGc1xlPV+OofnFVxtljFZhYEIbfPf9U
         Gzl3C3s6LLGRLRiCDfwvCdeJ4QkoNc+0P6MphGZkEw4mY+bZRy/N559V5vyaw0HR6l/M
         SsoIoKWkng1KIw+iclAPRKTNYMfVU3sa2t1UQ22h0mcgFBIZ4dj5kAv28RKfn1QLl+ud
         OvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702325293; x=1702930093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/I2A+kU/heU05z60USe87SZbkTbX5b5JkqKjVk3UqXg=;
        b=oet6gPIKVApQZtMBfK/MR0LRC59D6p4jUrAgoOGUOPJC8q28igSea6IV9Ggfbxwb5O
         j+azoEwaqYqU3YbBgDsvuOjq+yQdCAkeYwDMEXQ2UKbRPXJ1ustpU+uArYct5184o6eg
         zaeo07QRw9xzhD/0qS5jbtZ17lbIYoowxp0Vma/oUFC/FN52e6zQQLmoYFLbVvNeubRU
         JAypuMjF+Z1q36Db/xrVnfXoG7bbhJeYXM78K5E5f7yIK94ykoKZZn7xZDgaxsmU/FRr
         Gq7iNsKqsE5+qxeg6n1REbP2l/+2F0G4rmq/KszXhXoKW5aS+AwmPBBGClxVI05Ob5pC
         BwDA==
X-Gm-Message-State: AOJu0YzlORxeCAQ2VbNYQdETOvcUE2ybqrLs0A/mffi3sJMjrD/odf6e
        WdAwgGf1ziYupQH23XWXUtz9CGhRC7yrvgaQH3nzuw==
X-Google-Smtp-Source: AGHT+IGXWT5n91RWJekDXeM3hMRjGYDx8afvDMNTJMGu/CYe6+JgNLgbri08rgqjREwCSjnzSSN53VpS3dertjRjGGA=
X-Received: by 2002:a17:907:1dce:b0:a18:35e2:de31 with SMTP id
 og14-20020a1709071dce00b00a1835e2de31mr2027740ejc.63.1702325293358; Mon, 11
 Dec 2023 12:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20231024-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-1e0026ee032d@google.com>
 <9f38f4aa-c6b5-4786-a641-d02d8bd92f7f@acm.org>
In-Reply-To: <9f38f4aa-c6b5-4786-a641-d02d8bd92f7f@acm.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 11 Dec 2023 12:08:01 -0800
Message-ID: <CAFhGd8oQ-Z8e65-TOZPmNHR-rsPVRXNY8UZMDFcUScKZ6bbtJQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: fcoe: replace deprecated strncpy with strscpy
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 24, 2023 at 1:01=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 10/24/23 12:52, Justin Stitt wrote:
> > diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sy=
sfs.c
> > index e17957f8085c..7a3ca6cd3030 100644
> > --- a/drivers/scsi/fcoe/fcoe_sysfs.c
> > +++ b/drivers/scsi/fcoe/fcoe_sysfs.c
> > @@ -279,12 +279,10 @@ static ssize_t store_ctlr_mode(struct device *dev=
,
> >       if (count > FCOE_MAX_MODENAME_LEN)
> >               return -EINVAL;
> >
> > -     strncpy(mode, buf, count);
> > +     strscpy(mode, buf, count);
> >
> >       if (mode[count - 1] =3D=3D '\n')
> >               mode[count - 1] =3D '\0';
> > -     else
> > -             mode[count] =3D '\0';
> >
> >       switch (ctlr->enabled) {
> >       case FCOE_CTLR_ENABLED:
>
> Please consider to remove the code for copying the sysfs string and to
> use sysfs_match_string() instead.
>

Sorry, I'm not too familiar with sysfs strings here.

Let me know what you think of this patch [1].

> Thanks,
>
> Bart.
>

[1]: https://lore.kernel.org/r/20231211-strncpy-drivers-scsi-fcoe-fcoe_sysf=
s-c-v1-1-73b942238396@google.com

Thanks
Justin

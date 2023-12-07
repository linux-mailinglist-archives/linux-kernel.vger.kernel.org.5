Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDDA808820
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379411AbjLGMjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLGMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:39:37 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F4BA8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:39:41 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c659db0ce2so698936a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1701952781; x=1702557581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/2d4/WwckVFpUcYhl9cottD/fQXNOLH0HoIwOJzbDs=;
        b=Nu4+903Ihg3zdeaq8E1eiGT1fiTuINPEZT9EeLuzC8GnVuLgvApEa6Bfl2yLD+oALl
         Jx3KDjDT5BO1ayqibDpV2TM2U+aOgCOpbhi5WLDa4yq1/7mFrhJphccg6HyuMPmDa+8E
         pcCT/WO6Yj4+pbv4z4j10r2z9P82wW3SAr5j+yAukxnJLK5u3PcObplalVfMKjRPc1WU
         MBIsg97929i/552vzbmWm7he9A5C1uZtBvYVv7A2+ViYnoxd0pIKsN3XJqWIJ01tGXfW
         HGDt09vPnXw1D78xujGHxyzZe7hmv4jvsb+ja5GocXbKfhROa5a6EsD+iUy+feVInQr7
         MiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952781; x=1702557581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/2d4/WwckVFpUcYhl9cottD/fQXNOLH0HoIwOJzbDs=;
        b=IubkTmxFRfrO6eVoniEXAQtUpYqwQDMJ3cn0gOYI+4RmZTyxSVzUi/FOYcaswmU63b
         8ft1B8uB3wGXgJoB6f+n9LY+b9to1Goox9hHe+6L7ZnGevmsotzHhHupFS1JIEB+raHM
         Gj2JF4RjbGogQKDDxgvXQKsfvmamxNgFt6LhNQbn/BXuBXDVr8F001SXZp4B6EbFTc2K
         26u7iwd4gWbSGY+TTTyKSujvWAco9dsH6mq8hYa50yXw72QRaOETDY7MZIG6oyjoOHBt
         MOEWfkEKOENPTx3/EchOuXBmFN/j8CcFhhifE+7gBI5AKJbZeKYGSJLDyEnK2uScpkxO
         Bqfg==
X-Gm-Message-State: AOJu0Yyy6jxCnosgxbiRCqyCp+U6zwa40wAsbNwYmohuy6dB2o2XJtuS
        oS6IUEBqnothd07gmR1M/KcOoQPZWQNuKFKhRmqqIw==
X-Google-Smtp-Source: AGHT+IEzkgJQJnWYmMzJOq4pyyaNab9jZr2hC4d0IDCAojvZR7JADKfgyBDU2BAn/ZN5WrSI3I6Ay7Ly2RGbPXQlIP4=
X-Received: by 2002:a17:90a:d40e:b0:282:d080:feed with SMTP id
 r14-20020a17090ad40e00b00282d080feedmr2174637pju.40.1701952780872; Thu, 07
 Dec 2023 04:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20231205105207.1262928-1-naresh.solanki@9elements.com> <46b1d303-8104-4298-bd43-a649634f5393@gmail.com>
In-Reply-To: <46b1d303-8104-4298-bd43-a649634f5393@gmail.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 7 Dec 2023 18:09:30 +0530
Message-ID: <CABqG17jwAw6zqy9FLtZ3ppwLT+3fAQ21bGfMr4Xt5eTDm-jQMw@mail.gmail.com>
Subject: Re: [PATCH v4] regulator: event: Add regulator netlink event support
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,


On Thu, 7 Dec 2023 at 13:42, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> Hi Naresh,
>
> On 12/5/23 12:52, Naresh Solanki wrote:
> > This commit introduces netlink event support to the regulator subsystem.
> >
> > Changes:
> > - Introduce event.c and regnl.h for netlink event handling.
> > - Implement reg_generate_netlink_event to broadcast regulator events.
> > - Update Makefile to include the new event.c file.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>
> Thanks! I have somehow missed the earlier patches (or just don't
> remember seeing them). I _really_ like the idea of sending the regulator
> events as netlink multicasts!
>
> ...
>
> > +
> > +int reg_generate_netlink_event(const char *reg_name, u64 event)
> > +{
> > +     struct sk_buff *skb;
> > +     struct nlattr *attr;
> > +     struct reg_genl_event *edata;
> > +     void *msg_header;
> > +     int size;
> > +
> > +     /* allocate memory */
> > +     size = nla_total_size(sizeof(struct reg_genl_event)) +
> > +         nla_total_size(0);
> > +
> > +     skb = genlmsg_new(size, GFP_ATOMIC);
> > +     if (!skb)
> > +             return -ENOMEM;
> > +
> > +     /* add the genetlink message header */
> > +     msg_header = genlmsg_put(skb, 0, reg_event_seqnum++,
> > +                              &reg_event_genl_family, 0,
> > +                              REG_GENL_CMD_EVENT);
>
> Should the reg_event_seqnum++ be atomic or is access somehow serialized?
Yes making it atomic will be better.
>
> > +     if (!msg_header) {
> > +             nlmsg_free(skb);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* fill the data */
> > +     attr = nla_reserve(skb, REG_GENL_ATTR_EVENT, sizeof(struct reg_genl_event));
> > +     if (!attr) {
> > +             nlmsg_free(skb);
> > +             return -EINVAL;
> > +     }
> > +
> > +     edata = nla_data(attr);
> > +     memset(edata, 0, sizeof(struct reg_genl_event));
> > +
> > +     strscpy(edata->reg_name, reg_name, sizeof(edata->reg_name));
> > +     edata->event = event;
> > +
> > +     /* send multicast genetlink message */
> > +     genlmsg_end(skb, msg_header);
> > +     size = genlmsg_multicast(&reg_event_genl_family, skb, 0, 0, GFP_ATOMIC);
> > +
> > +     return size;
> > +}
> > +
>
> ...
>
> > diff --git a/include/uapi/regulator/regulator.h b/include/uapi/regulator/regulator.h
> > new file mode 100644
> > index 000000000000..d2b5612198b6
> > --- /dev/null
> > +++ b/include/uapi/regulator/regulator.h
> > @@ -0,0 +1,90 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Regulator uapi header
> > + *
> > + * Author: Naresh Solanki <Naresh.Solanki@9elements.com>
> > + */
> > +
> > +#ifndef _UAPI_REGULATOR_H
> > +#define _UAPI_REGULATOR_H
> > +
> > +#ifdef __KERNEL__
> > +#include <linux/types.h>
> > +#else
> > +#include <stdint.h>
> > +#endif
> > +
> > +/*
> > + * Regulator notifier events.
> > + *
> > + * UNDER_VOLTAGE  Regulator output is under voltage.
> > + * OVER_CURRENT   Regulator output current is too high.
> > + * REGULATION_OUT Regulator output is out of regulation.
> > + * FAIL           Regulator output has failed.
> > + * OVER_TEMP      Regulator over temp.
> > + * FORCE_DISABLE  Regulator forcibly shut down by software.
> > + * VOLTAGE_CHANGE Regulator voltage changed.
> > + *                Data passed is old voltage cast to (void *).
> > + * DISABLE        Regulator was disabled.
> > + * PRE_VOLTAGE_CHANGE   Regulator is about to have voltage changed.
> > + *                      Data passed is "struct pre_voltage_change_data"
> > + * ABORT_VOLTAGE_CHANGE Regulator voltage change failed for some reason.
> > + *                      Data passed is old voltage cast to (void *).
> > + * PRE_DISABLE    Regulator is about to be disabled
> > + * ABORT_DISABLE  Regulator disable failed for some reason
> > + *
> > + * NOTE: These events can be OR'ed together when passed into handler.
> > + */
> > +
> > +#define REGULATOR_EVENT_UNDER_VOLTAGE                0x01
> > +#define REGULATOR_EVENT_OVER_CURRENT         0x02
> > +#define REGULATOR_EVENT_REGULATION_OUT               0x04
> > +#define REGULATOR_EVENT_FAIL                 0x08
> > +#define REGULATOR_EVENT_OVER_TEMP            0x10
> > +#define REGULATOR_EVENT_FORCE_DISABLE                0x20
> > +#define REGULATOR_EVENT_VOLTAGE_CHANGE               0x40
> > +#define REGULATOR_EVENT_DISABLE                      0x80
> > +#define REGULATOR_EVENT_PRE_VOLTAGE_CHANGE   0x100
> > +#define REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE 0x200
> > +#define REGULATOR_EVENT_PRE_DISABLE          0x400
> > +#define REGULATOR_EVENT_ABORT_DISABLE                0x800
> > +#define REGULATOR_EVENT_ENABLE                       0x1000
> > +/*
> > + * Following notifications should be emitted only if detected condition
> > + * is such that the HW is likely to still be working but consumers should
> > + * take a recovery action to prevent problems esacalating into errors.
>
> It's easier to spot my own typos when someone throws them at my face :)
> Maybe fix the 'esacalating' while shuffling these? (don't know if it's
> preferred to first move everything and only do typofix as own patch - in
> which case it definitely does not need to be done as a part of this
> series. Just commented on this as I noticed it now)
Yes.  I missed fixing the typo.
>
> > + */
> > +#define REGULATOR_EVENT_UNDER_VOLTAGE_WARN   0x2000
> > +#define REGULATOR_EVENT_OVER_CURRENT_WARN    0x4000
> > +#define REGULATOR_EVENT_OVER_VOLTAGE_WARN    0x8000
> > +#define REGULATOR_EVENT_OVER_TEMP_WARN               0x10000
> > +#define REGULATOR_EVENT_WARN_MASK            0x1E000
> > +
> > +struct reg_genl_event {
> > +     char reg_name[32];
> > +     uint64_t event;
> > +};
>
> Do you think we could and / or should separate the event type and event
> severity to own attributes here? I wonder if we will see more
> 'severities' of events in the future. I see we have currently some
> activity for deciding if a regulator event should result for example a
> "data storage protection" by shutting down storage hardware before a
> back-up capacitor runs out of energy. Maybe we see more cases where the
> user-space needs to decide whether to run a (partial) system shutdown or
> do some other action based on regulator events.
>
> I have a feeling that there will be "actions" which are common (like
> system shutdown or data flushing) and could utilize some generic
> user-space daemon - maybe the severity is something such a generic
> daemon could use to decide if shutdown/flush/whatsoever is needed? If
> so, being able to add new severities may be needed - and duplicating
> event flags for all severities may not scale.
>
> OTOH, it's not that hard to append new netlink attributes to the end of
> the message to give user-space a hint regarding what should be done. In
> that sense this is not something I would insist - just wonder if you see
> it sensible?

When I wrote the code, I kept in mind to make sure to receive all events
from regulators so that userspace application (in my case BMC
application which does power sequence) has regulator events information.
Hence I assumed that its upto userspace application to decide on corrective
action based on events of interest.

At the same time I think having it in a way which is very generic & meets
requirement of many use case would be better.

Please correct me if my understanding is inaccurate.
As I understand from your inputs, receiving severity information along
with event would help application decide corrective information insteading
of decoding regulator events.

>
> > +
> > +/* attributes of reg_genl_family */
> > +enum {
> > +     REG_GENL_ATTR_UNSPEC,
> > +     REG_GENL_ATTR_EVENT,    /* reg event info needed by user space */
> > +     __REG_GENL_ATTR_MAX,
> > +};
> > +
> > +#define REG_GENL_ATTR_MAX (__REG_GENL_ATTR_MAX - 1)
> > +
> > +/* commands supported by the reg_genl_family */
> > +enum {
> > +     REG_GENL_CMD_UNSPEC,
> > +     REG_GENL_CMD_EVENT,     /* kernel->user notifications for reg events */
> > +     __REG_GENL_CMD_MAX,
> > +};
> > +
> > +#define REG_GENL_CMD_MAX (__REG_GENL_CMD_MAX - 1)
> > +
> > +#define REG_GENL_FAMILY_NAME         "reg_event"
> > +#define REG_GENL_VERSION             0x01
> > +#define REG_GENL_MCAST_GROUP_NAME    "reg_mc_group"
>
> I am wondering what will the user-space handlers look like? Do we think
> that there will be a 'I am interested in _all_ regulator multicast
> events' type of listener, or do we think there will be listeners who
> would like to listen only for a subset of regulator netlink notifications?
>
> Asking this just because I wonder if we should be prepared for more than
> one regulator multicast group? Do you think that an ability to say "Hey,
> I'd like to listen for under-voltage events only" or "I would like to
> get all temperature-related notifications" should/could be supported by
> more specific multicast groups or is that just over-engineering at this
> point?
Current implementation is such that all events will be sent.
But I agree with you that it is not something desired as sometimes
application might not be interested in all events.
Also I'm not sure on multicast group, as currently only one group
exist for regulator event & how adding additional group would help.


>
> It has been a long while since I wrote netlink code. So, if this makes
> no sense to you it's probably me who is overlooking something.
I'm aligned to make sure regulator netlink serves wider purpose &
hence your inputs are highly valuable.

Based on inputs provided by you(please add if missed anything):
1. Add an attribute severity & set it if event is of critical nature like:
    under-voltage, over-current, event_fail & *any others* ?.
2. Ability to receive specific set of regulator events instead of all events.

Regards,
Naresh

>
> > +
> > +#endif /* _UAPI_REGULATOR_H */
> >
> > base-commit: 753e4d5c433da57da75dd4c3e1aececc8e874a62
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>

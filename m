Return-Path: <linux-kernel+bounces-10087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD881CFDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C81F23205
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F47C1EB47;
	Fri, 22 Dec 2023 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K+5VMif8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A72FC3A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db99bad7745so2210124276.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703284966; x=1703889766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRfe3st5Sq+6jYTfqEvbxYNV9ZVvDUCiVKsaDs8UPZg=;
        b=K+5VMif8LmUVhet8VzLt6mVJhCBoGNnaoIxsrljT0Q6T54IoHW10u3wR8DIt+fNPPt
         NKR1RUPxXYfmD/clpgWa8hnxPL62rcosSc9OOokVxveCfThOff6TZprb7Qk8YZodK/p6
         xbrwGTHsCD1Mdgg5rYTNCL4VNu3U5izRw0XfgfCxwIVAMt82oQs7Y2yVEsIpynbXk/Vi
         vwMorZ8tdjGvE0tBbHLg2LI3FbqaCSXRa9LG0WdJX9ePxgT781gQlGXXwQOl9N/Ohw3g
         1pEbcRryz0EbMLiyIAMH7Oj2QbqKuIS7JHi9d1MG41SvoitLmS8TRFo6j5YbkzjT12vX
         252A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703284966; x=1703889766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRfe3st5Sq+6jYTfqEvbxYNV9ZVvDUCiVKsaDs8UPZg=;
        b=tu5hYpo9U4Tljx/dXSAPvfi+NXzujA8GZrOUEE6nNVFhNveTnGelywnQ9LpwP3cBmo
         Lbf4JSE5f3NyhOKoyMWzKPA15TmrteS+jSF28nANJ9J4BbOt7UzrUBM2du4XVF3II9Xm
         RsVNIA8riKKRSrotJ5QHJIT/TcyitsyqVs+5yXXYXFhIZtGy4bQm2vKnaoe5PoYllwKZ
         Gcj6DU15QB/ydPOnhpW1NIx84aPliBx4QvDpz0xMimRdXd2hz9SrjB5JcNtaFFFzqkJa
         +w8Fai7rEpKspVujhMFoFx0YNUj/2WXHxpZqckEFVmv6J2kPtQBNuWe0opTtDhZcqQSJ
         Xz+w==
X-Gm-Message-State: AOJu0YzpCAyUUWmkmDnOH/vytkyRBrfk5ZzqoUoFGfwLFhdxqIJud+H9
	BJ4RKKw9+wSCcqduYYj/fPakAwi/7z1r5yIL5jcollqQYEHb
X-Google-Smtp-Source: AGHT+IHhe8gtJ2Jy890CtHKaIWwDsBVan3b58VTz5sDuWmxN3cj/Uo7ROSdRdcB3Nvh6s8vP9wSpox+867vdOU3UAHQ=
X-Received: by 2002:a25:dccc:0:b0:db7:dacf:2f3a with SMTP id
 y195-20020a25dccc000000b00db7dacf2f3amr1626639ybe.129.1703284966179; Fri, 22
 Dec 2023 14:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-4-mic@digikod.net>
 <CAHC9VhQTvFp+i=j7t+55EnG44xg=Pmvkh=Oq=e7ddJWDZXLeSA@mail.gmail.com> <20231221.eij3poa3Se4b@digikod.net>
In-Reply-To: <20231221.eij3poa3Se4b@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Dec 2023 17:42:35 -0500
Message-ID: <CAHC9VhRiUOe9enkCOko0mGehxt+2tbJNGoJm=jmauhZSPFvzRg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/7] landlock: Log ruleset creation and release
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@google.com>, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:45=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Dec 20, 2023 at 04:22:15PM -0500, Paul Moore wrote:
> > On Thu, Sep 21, 2023 at 2:17=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > Add audit support for ruleset/domain creation and release ...

...

> > > +/* Inspired by dump_common_audit_data(). */
> > > +static void log_task(struct audit_buffer *const ab)
> > > +{
> > > +       /* 16 bytes (TASK_COMM_LEN) */
> > > +       char comm[sizeof(current->comm)];
> > > +
> > > +       /*
> > > +        * Uses task_pid_nr() instead of task_tgid_nr() because of ho=
w
> > > +        * credentials and Landlock work.
> > > +        */
> > > +       audit_log_format(ab, "tid=3D%d comm=3D", task_pid_nr(current)=
);
> > > +       audit_log_untrustedstring(ab,
> > > +                                 memcpy(comm, current->comm, sizeof(=
comm)));
> > > +}
> >
> > Depending on how log_task() is used, it may be redundant with respect
> > to the existing SYSCALL record.  Yes, there is already redundancy with
> > the AVC record, but that is a legacy problem and not something we can
> > easily fix, but given that the Landlock records are new we have an
> > opportunity to do things properly :)
>
> Indeed, it would make it simpler too. I wasn't sure how standalone a
> record should be, but I guess there tools should be able to look for a
> set of related records (e.g. event with a SYSCALL record matching a PID
> and a LANDLOCK record).

I believe ausearch will output the entire event when it matches on a
field in one of the event's records.

> > > +void landlock_log_create_ruleset(struct landlock_ruleset *const rule=
set)
> > > +{
> > > +       struct audit_buffer *ab;
> > > +
> > > +       WARN_ON_ONCE(ruleset->id);
> > > +
> > > +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LAN=
DLOCK);
> > > +       if (!ab)
> > > +               /* audit_log_lost() call */
> > > +               return;
> > > +
> > > +       ruleset->id =3D atomic64_inc_return(&ruleset_and_domain_count=
er);
> > > +       log_task(ab);
> > > +       audit_log_format(ab,
> > > +                        " op=3Dcreate-ruleset ruleset=3D%llu handled=
_access_fs=3D",
> > > +                        ruleset->id);
> >
> > "handled_access_fs" seems a bit long for a field name, is there any
> > reason why it couldn't simply be "access_fs" or something similar?
>
> "handled_access_fs" is from the landlock_create_ruleset(2) API, so I'd
> like to use the same name.

Okay, that's a reasonable reason.

> However, because the types of handled access
> rights for a ruleset will expand (e.g. we now have a
> handled_access_net), I'm wondering if it would be better to keep this
> (growing) one-line record or if we should use several records for a
> ruleset creation (i.e. one line per type of handled access righs).

I think it would be better to have a single record for rulesets rather
than multiple records all dealing with rulesets.

> > > +               id =3D ruleset->hierarchy->id;
> > > +               WARN_ON_ONCE(ruleset->id);
> > > +       } else {
> > > +               name =3D "ruleset";
> > > +               id =3D ruleset->id;
> > > +       }
> > > +       WARN_ON_ONCE(!id);
> > > +
> > > +       /*
> > > +        * Because this might be called by kernel threads, logging
> > > +        * related task information with log_task() would be useless.
> > > +        */
> > > +       audit_log_format(ab, "op=3Drelease-%s %s=3D%llu", name, name,=
 id);
> >
> > This starts to get a little tricky.  The general guidance is that for
> > a given audit record type, e.g. AUDIT_LANDLOCK, there should be no
> > change in presence or ordering of fields, yet in
> > landlock_log_create_ruleset() we log the permission information and
> > here in landlock_log_release_ruleset() we do not.  The easy fix is to
> > record the permission information here as well, or simply use a
> > "handled_access_fs=3D?" placeholder.  Something to keep in mind as you
> > move forward.
>
> OK, I used different "op" to specify the related fields, but I should
> use a dedicated record type when it makes sense instead. My reasoning
> was that it would be easier to filter on one or two record types, but
> I like the fixed set of fields per record type.
>
> I plan to add a few record types, something like that:
>
> For a ruleset creation event, several grouped records:
> - AUDIT_LANDLOCK_RULESET: "id=3D[new ruleset ID] op=3Dcreate"
> - AUDIT_LANDLOCK_ACCESS: "type=3D[fs or net] rights=3D[bitmask]"

I'm guessing that LANDLOCK_RULESET would be for policy changes, and
LANDLOCK_ACCESS would be for individual access grants or denials?  If
so, that looks reasonable.

> For rule addition, several records per landlock_add_rule(2) call.
> Example with a path_beneath rule:
> - AUDIT_LANDLOCK_RULESET: "id=3D[ruleset ID] op=3Dadd_rule"
> - AUDIT_LANDLOCK_PATH: "scope=3Dbeneath path=3D[file path] dev=3D ino=3D"
> - AUDIT_LANDLOCK_ACCESS: "type=3Dfs rights=3D[bitmask]"

I worry that LANDLOCK_PATH is too much of a duplicate for the existing
PATH record.  Assuming the "scope=3D" field is important, could it live
in the LANDLOCK_ACCESS record and then you could do away with the
dedicated LANDLOCK_PATH record?  Oh, wait ... this is to record the
policy, not a individual access request, gotcha.  If that is the case
and RULESET, PATH, ACCESS are all used simply to record the policy
information I might suggest creation of an AUDIT_LANDLOCK_POLICY
record that captures all of the above.  If you think that is too
cumbersome, then perhaps you can do the object/access-specific record
type, e.g. AUDIT_LANDLOCK_POLICY_FS and AUDIT_LANDLOCK_POLICY_NET.

You also shouldn't reuse the "type=3D" field.  Steve gets grumpy when
people reuse field names for different things.  You can find a
reasonably complete list of fields here:
https://github.com/linux-audit/audit-documentation/blob/main/specs/fields/f=
ield-dictionary.csv

> For domain creation/restriction:
> - AUDIT_LANDLOCK_DOMAIN: "id=3D[new domain ID] op=3Dcreate"
> - AUDIT_LANDLOCK_RULESET: "id=3D[ruleset ID] op=3Duse"

I imagine you could capture this in the policy record type?

> For ruleset release:
> - AUDIT_LANDLOCK_RULESET: "id=3D[ruleset ID] op=3Drelease"
>
> For domain release:
> - AUDIT_LANDLOCK_DOMAIN: "id=3D[domain ID] op=3Drelease"

Same with the above two.

> For denied FS access:
> - AUDIT_LANDLOCK_DENIAL: "id=3D[domain ID] op=3Dmkdir"
> - AUDIT_LANDLOCK_PATH: "scope=3Dexact path=3D[file path] dev=3D ino=3D"

I would use a single record type, i.e. AUDIT_LANDLOCK_ACCESS, to
capture both access granted and denied events.  I'd also omit the
dedicated LANDLOCK_PATH record here in favor of the generic PATH
record (see my comments above).

> For denied net access:
> - AUDIT_LANDLOCK_DENIAL: "id=3D[domain ID] op=3Dconnect"
> - AUDIT_LANDLOCK_PORT: "port=3D"

I would look at the SOCKADDR record type instead of introducing a new
LANDLOCK_PORT type.

> I guess it will still be OK to expand a record type with new appended
> fields right? For instance, could we append a "flags" field to a
> AUDIT_LANDLOCK_RULESET record (because it may not make sense to create a
> dedicated record type for that)?

Of course, one can always add fields to an existing record type with
the understanding that they MUST be added to the end.

--=20
paul-moore.com


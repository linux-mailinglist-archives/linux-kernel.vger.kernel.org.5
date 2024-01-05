Return-Path: <linux-kernel+bounces-18388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8F3825C63
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DAD1F2424F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521792D780;
	Fri,  5 Jan 2024 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dyJLjct8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3905358B3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbd029beef4so825826276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 14:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704492792; x=1705097592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFLXEkuf5S0teJbni+kf0gZVyAMOGMoUV23JohFpwpU=;
        b=dyJLjct8JGo02L+ylbdBhkpDQCi+zVdtFgnEMs6q3zmAcBvdnjDE1CS+3P2lrug/8E
         oA+vDqBemhceJM1vew1mVkp7CJwzGujZYzVUJDhjvinlMXhb+TEIH4jO9ZvlPTM42w8D
         XXTFhMOulfjANj1ODEmA6SInDvFP4sxCtPx/hhFYEQk2Vqp22whAb4HNgkDv6as5Eqix
         1FgG494x1KUD/Z+9Eg7+cydK1Rc4G0JG4AuipOUlbq0U6TgAR2MCdfCo4zpHd6+qGOhN
         G7RD6EiJyj9ef25Ge9dr5orD3njxhR0lcYMIPEU68MBZIWDQTAAUgKR/nSKEIolrfKs4
         jh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704492792; x=1705097592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFLXEkuf5S0teJbni+kf0gZVyAMOGMoUV23JohFpwpU=;
        b=RQs4X6a7+0IIs+RRLsSPQV3JoEgP64649NQRppQeRRKIjJ9+oJE+lVZ1+Tl5M6P3ax
         ESik0hEgwl4UoOeI8VEjiGA7UNk2kgOipewsn/I4iw4Lju9TApRnVzkt6k1Aob7+RLWG
         0oib8RAXXXHrXhh1UuMV3fByzNLKzvA9j+Xju5eUCbZWOuyEi0VXKKS18E74rf5fNWHz
         qnIJYzt1RRjrOuEDQt84VTRzs6JSst556bFIpO3tF3sTH/Xe+1jyYhw0VR0rR/cMjeB2
         39dc7JROtaO59YlYgZ0Hs6DHaN8DeYgafkvma3RDAqCrnenMg6jVb4Qwhj6XR3c2r1yD
         d2bw==
X-Gm-Message-State: AOJu0Yw6zL/M0QKvI26LLPSfBV9U4xw+7MIZ2oGgoHI89kfByBAFcizp
	B44J9qn0oQGYeFiqW6jyY2c1qcZqLL4MEBE/QxMkTtO6rHAr
X-Google-Smtp-Source: AGHT+IEkC9LGjCYjd2rASwNH+fpfnIErYtBXHc9AO1zzyXMpmBhBihEzAWAi9eoEsOn23M88mu6CkcCdg4I+Vpr1Xzg=
X-Received: by 2002:a25:ad81:0:b0:dbd:9a04:f397 with SMTP id
 z1-20020a25ad81000000b00dbd9a04f397mr122433ybi.14.1704492791662; Fri, 05 Jan
 2024 14:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-4-mic@digikod.net>
 <CAHC9VhQTvFp+i=j7t+55EnG44xg=Pmvkh=Oq=e7ddJWDZXLeSA@mail.gmail.com>
 <20231221.eij3poa3Se4b@digikod.net> <CAHC9VhRiUOe9enkCOko0mGehxt+2tbJNGoJm=jmauhZSPFvzRg@mail.gmail.com>
 <20231229.aex0ijae2The@digikod.net>
In-Reply-To: <20231229.aex0ijae2The@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Jan 2024 17:13:00 -0500
Message-ID: <CAHC9VhS4qcn4=3eeOx3vOeHsy3MkDx5MExhPxWYWgH4kF4ZZBA@mail.gmail.com>
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

On Fri, Dec 29, 2023 at 12:42=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Fri, Dec 22, 2023 at 05:42:35PM -0500, Paul Moore wrote:
> > On Thu, Dec 21, 2023 at 1:45=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Wed, Dec 20, 2023 at 04:22:15PM -0500, Paul Moore wrote:
> > > > On Thu, Sep 21, 2023 at 2:17=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > Add audit support for ruleset/domain creation and release ...

...

> > > > > +void landlock_log_create_ruleset(struct landlock_ruleset *const =
ruleset)
> > > > > +{
> > > > > +       struct audit_buffer *ab;
> > > > > +
> > > > > +       WARN_ON_ONCE(ruleset->id);
> > > > > +
> > > > > +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC, AUDIT=
_LANDLOCK);
> > > > > +       if (!ab)
> > > > > +               /* audit_log_lost() call */
> > > > > +               return;
> > > > > +
> > > > > +       ruleset->id =3D atomic64_inc_return(&ruleset_and_domain_c=
ounter);
> > > > > +       log_task(ab);
> > > > > +       audit_log_format(ab,
> > > > > +                        " op=3Dcreate-ruleset ruleset=3D%llu han=
dled_access_fs=3D",
> > > > > +                        ruleset->id);
> > > >
> > > > "handled_access_fs" seems a bit long for a field name, is there any
> > > > reason why it couldn't simply be "access_fs" or something similar?
> > >
> > > "handled_access_fs" is from the landlock_create_ruleset(2) API, so I'=
d
> > > like to use the same name.
> >
> > Okay, that's a reasonable reason.
> >
> > > However, because the types of handled access
> > > rights for a ruleset will expand (e.g. we now have a
> > > handled_access_net), I'm wondering if it would be better to keep this
> > > (growing) one-line record or if we should use several records for a
> > > ruleset creation (i.e. one line per type of handled access righs).
> >
> > I think it would be better to have a single record for rulesets rather
> > than multiple records all dealing with rulesets.
>
> I guess you mean to not create multiple record types specific to ruleset
> creation.

Yes.

> Reusing existing record types (e.g. path) should be OK even
> for a ruleset creation. However, as proposed below, we might still want
> a LANDLOCK_ACCESS record type (that can be reused for denied accesses).

I would want to see the code to make sure we are not misunderstanding
each other, but I believe you are on the right track.

> > > > > +               id =3D ruleset->hierarchy->id;
> > > > > +               WARN_ON_ONCE(ruleset->id);
> > > > > +       } else {
> > > > > +               name =3D "ruleset";
> > > > > +               id =3D ruleset->id;
> > > > > +       }
> > > > > +       WARN_ON_ONCE(!id);
> > > > > +
> > > > > +       /*
> > > > > +        * Because this might be called by kernel threads, loggin=
g
> > > > > +        * related task information with log_task() would be usel=
ess.
> > > > > +        */
> > > > > +       audit_log_format(ab, "op=3Drelease-%s %s=3D%llu", name, n=
ame, id);
> > > >
> > > > This starts to get a little tricky.  The general guidance is that f=
or
> > > > a given audit record type, e.g. AUDIT_LANDLOCK, there should be no
> > > > change in presence or ordering of fields, yet in
> > > > landlock_log_create_ruleset() we log the permission information and
> > > > here in landlock_log_release_ruleset() we do not.  The easy fix is =
to
> > > > record the permission information here as well, or simply use a
> > > > "handled_access_fs=3D?" placeholder.  Something to keep in mind as =
you
> > > > move forward.
> > >
> > > OK, I used different "op" to specify the related fields, but I should
> > > use a dedicated record type when it makes sense instead. My reasoning
> > > was that it would be easier to filter on one or two record types, but
> > > I like the fixed set of fields per record type.
> > >
> > > I plan to add a few record types, something like that:
> > >
> > > For a ruleset creation event, several grouped records:
> > > - AUDIT_LANDLOCK_RULESET: "id=3D[new ruleset ID] op=3Dcreate"
> > > - AUDIT_LANDLOCK_ACCESS: "type=3D[fs or net] rights=3D[bitmask]"
> >
> > I'm guessing that LANDLOCK_RULESET would be for policy changes, and
> > LANDLOCK_ACCESS would be for individual access grants or denials?  If
> > so, that looks reasonable.
>
> I was thinking about using LANDLOCK_ACCESS for both ruleset creation and
> denied accesses. That would mkae a ruleset creation event easier to
> parse and more flexible. Does that look good?

In general, configuration events like ruleset creation use one record
type, while individual access requests use a different record type.

> Otherwise, we can use this instead:
>
> - AUDIT_LANDLOCK_RULESET: "ruleset=3D[new ruleset ID]
>   handled_access_fs=3D[bitmask] handled_access_net=3D[bitmask]"
>
> > > For rule addition, several records per landlock_add_rule(2) call.
> > > Example with a path_beneath rule:
> > > - AUDIT_LANDLOCK_RULESET: "id=3D[ruleset ID] op=3Dadd_rule"
> > > - AUDIT_LANDLOCK_PATH: "scope=3Dbeneath path=3D[file path] dev=3D ino=
=3D"
> > > - AUDIT_LANDLOCK_ACCESS: "type=3Dfs rights=3D[bitmask]"
> >
> > I worry that LANDLOCK_PATH is too much of a duplicate for the existing
> > PATH record.  Assuming the "scope=3D" field is important, could it live
> > in the LANDLOCK_ACCESS record and then you could do away with the
> > dedicated LANDLOCK_PATH record?  Oh, wait ... this is to record the
> > policy, not a individual access request, gotcha.  If that is the case
> > and RULESET, PATH, ACCESS are all used simply to record the policy
> > information I might suggest creation of an AUDIT_LANDLOCK_POLICY
> > record that captures all of the above.  If you think that is too
> > cumbersome, then perhaps you can do the object/access-specific record
> > type, e.g. AUDIT_LANDLOCK_POLICY_FS and AUDIT_LANDLOCK_POLICY_NET.
>
> OK, what about this records for *one* rule addition event?
>
> - AUDIT_LANDLOCK_RULE: "ruleset=3D[ruleset ID] rule_type=3Dpath_beneath
>   allowed_access=3D[bitmask]"
> - AUDIT_PATH: "path=3D[file path] dev=3D ino=3D ..."

If the pathname above is for the landlock rule, it should be separate
from the existing AUDIT_PATH record.  See my previous comments above,
when I was talking about using the existing AUDIT_PATH record I was
confusing the rule creation event with the permission check event.

> However, because struct landlock_path_beneath_attr can evolve and get
> new fields which might be differents than the landlock_net_port_attr's
> ones, wouldn't it be wiser to use a dedicated AUDIT_LANDLOCK_RULE_FS or
> AUDIT_LANDLOCK_RULE_PATH_BENEATH record type? These names are getting a
> bit long though, but types match the UAPI.

I believe we were thinking similarly, see my previous comments above
about AUDIT_LANDLOCK_POLICY_FS and AUDIT_LANDLOCK_POLICY_NET, etc.

> > You also shouldn't reuse the "type=3D" field.  Steve gets grumpy when
> > people reuse field names for different things.  You can find a
> > reasonably complete list of fields here:
> > https://github.com/linux-audit/audit-documentation/blob/main/specs/fiel=
ds/field-dictionary.csv
>
> OK
>
> >
> > > For domain creation/restriction:
> > > - AUDIT_LANDLOCK_DOMAIN: "id=3D[new domain ID] op=3Dcreate"
> > > - AUDIT_LANDLOCK_RULESET: "id=3D[ruleset ID] op=3Duse"
> >
> > I imagine you could capture this in the policy record type?
>
> What about this?
>
> - AUDIT_LANDLOCK_RESTRICT: "ruleset=3D[ruleset ID] domain=3D[new domain I=
D]
>   restrict_type=3Dself"
>
> >
> > > For ruleset release:
> > > - AUDIT_LANDLOCK_RULESET: "id=3D[ruleset ID] op=3Drelease"
> > >
> > > For domain release:
> > > - AUDIT_LANDLOCK_DOMAIN: "id=3D[domain ID] op=3Drelease"
> >
> > Same with the above two.
>
> - AUDIT_LANDLOCK_RELEASE: "id=3D[ruleset or domain ID]
>   release_type=3D[ruleset or domain]"
>
> The issue with this record is that the "id" field is not the same as for
> AUDIT_LANDLOCK_{RESTRICT,RULE}... To have "domain" or "ruleset" fields,
> a dedicated record type would be cleaner:
> AUDIT_LANDLOCK_RELEASE_{RULESET,DOMAIN}.

If you need separate record types, you need separate record types.
Regardless of the types used, we need to make sure an administrator
can match up a creation event with a destruction event.

> > > For denied FS access:
> > > - AUDIT_LANDLOCK_DENIAL: "id=3D[domain ID] op=3Dmkdir"
> > > - AUDIT_LANDLOCK_PATH: "scope=3Dexact path=3D[file path] dev=3D ino=
=3D"
> >
> > I would use a single record type, i.e. AUDIT_LANDLOCK_ACCESS, to
> > capture both access granted and denied events.  I'd also omit the
> > dedicated LANDLOCK_PATH record here in favor of the generic PATH
> > record (see my comments above).
>
> Makes sense for the generic PATH record. We would get this:
>
> - AUDIT_LANDLOCK_ACCESS: "domain=3D[domain ID] op=3Dmkdir result=3Ddenied=
"
> - AUDIT_PATH: "path=3D[file path] dev=3D ino=3D ..."
>
> >
> > > For denied net access:
> > > - AUDIT_LANDLOCK_DENIAL: "id=3D[domain ID] op=3Dconnect"
> > > - AUDIT_LANDLOCK_PORT: "port=3D"
> >
> > I would look at the SOCKADDR record type instead of introducing a new
> > LANDLOCK_PORT type.
>
> Good, this is already filled so I don't have to do anything except the
> AUDIT_LANDLOCK_ACCESS record.
>
> However, I'm wondering if it would be OK to create a synthetic sockaddr
> struct to generate a sockaddr audit record when adding a new net_port
> rule. In this case, we'd have to fill the fill the source and
> destination addresses with fake values (zeros?) and the source and
> destination ports with the rule's port. The pros is that it would not
> add a new record type but the cons is that it will probably not work
> with future net_port rule properties. It would also be inconsistent with
> AUDIT_LANDLOCK_ACCESS.
>
> What about this instead?
>
> - AUDIT_LANDLOCK_RULE: "ruleset=3D[ruleset ID] rule_type=3Dnet_port
>   allowed_access=3D[bitmask]"
> - AUDIT_LANDLOCK_PORT: "port=3D[port number]"

Just as we probably don't want to reuse the AUDIT_PATH record, we
probably shouldn't reuse the sockaddr record.

--=20
paul-moore.com


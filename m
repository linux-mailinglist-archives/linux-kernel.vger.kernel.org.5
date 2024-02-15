Return-Path: <linux-kernel+bounces-67781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C08570AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D371F23619
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFF813B299;
	Thu, 15 Feb 2024 22:44:50 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700B813DBB3;
	Thu, 15 Feb 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037090; cv=none; b=vEqvoAkrcYjiScBQ5vkB7fKmslSZK5FdVAakHOrPVTCD9867bF6hYlQqulWK+cdHtZJXGBqGP1Cej8sLLTvRgnrKYSL2mEji60ATyB3qtnemNZkj6u5Jq3t0KvOYeMn63OrAhtQeDNfxAMXkGmi/z1XS8iupOGa5rJyhQ2r9Qho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037090; c=relaxed/simple;
	bh=7a4CRGflS3UeQaHyITsY4L13WF6Py9FXyYYu/eRX+qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucy/85zGSi1MBckd1QKYW9OjUEucBtbgAHll9cZYTxQGsiwoSSx9/E8pYSyqmAkcVqkXtr1QbEK2gWVDqyoGQv/EoCocRTPofcmwceC1WbCxm18tVYVIWUQUyOE+BIZCnzOplOiCNtSaemfbwjx7x8MAEqgPHO071GT0aZ2nvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 41FMi83U029550;
	Thu, 15 Feb 2024 16:44:08 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 41FMi7wZ029549;
	Thu, 15 Feb 2024 16:44:07 -0600
Date: Thu, 15 Feb 2024 16:44:06 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: "Xing, Cedric" <cedric.xing@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Middleton <dan.middleton@linux.intel.com>,
        Samuel Ortiz <sameo@rivosinc.com>, Qinkun Bao <qinkun@google.com>,
        "Yao, Jiewen" <jiewen.yao@intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
        linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Message-ID: <20240215224406.GA29515@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com> <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com> <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com> <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com> <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch> <22088ed3-51a4-415f-932c-db84c92a2812@intel.com> <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com> <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com> <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch> <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 15 Feb 2024 16:44:08 -0600 (CST)

On Mon, Feb 12, 2024 at 11:36:27PM -0800, Xing, Cedric wrote:

Hi, I hope the week is going well for everyone.

> On 2/9/2024 12:58 PM, Dan Williams wrote:
> >James Bottomley wrote:
> >>Just to correct this: IMA uses its own log format, but I think this was
> >>a mistake long ago and the new log should use TCG2 format so all the
> >>tools know how to parse it.
> >
> >Is this a chance to nudge IMA towards a standard log format? In other
> >words, one of the goals alongside userspace consumers of the RTMR log
> >would be for IMA to support it as well as an alternate in-kernel backend
> >next to TPM. IMA-over-TPM continues with its current format,
> >IMA-over-RTMR internally unifies with the log format that is shared with
> >RTMR-user-ABI.

> I'm not a TCG expert. As far as I know,
> https://trustedcomputinggroup.org/wp-content/uploads/TCG-PC-Client-Platform-Firmware-Profile-Version-1.06-Revision-52_pub-1.pdf
> defines the event types for TCG2 logs for firmware uses only. I
> cannot find a spec that defines event types for OS or
> applications. We may reuse the firmware event types for Linux but I
> doubt they can accommodate IMA.
>
> IMHO, we don't have to follow TCG2 format because TDX is never TPM,
> nor are any other TEEs that support runtime measurements. The
> existing TCG2 format looks to me somewhat like ASN.1 - well defined
> but schema is needed to decode. In contrast, JSON is a lot more
> popular than ASN.1 nowadays because it's human readable and doesn't
> require a schema. I just wonder if we should introduce a text based
> log format. We could make the log a text file, in which each line is
> an event record and the digest of the line is extended to the
> specified runtime measurement register. The content of each line
> could be free-form at the ABI level, but we can still recommend a
> convention for applications - e.g., the first word/column must be an
> URL for readers to find out the format/syntax of the rest of the
> line. Thoughts?

A common text based security event description format, based on JSON
encoding of LSM security event descriptions, surfaced through
securityfs, has already been implemented, proposed and has been pushed
out for review twice.

The TSEM LSM is designed to be a generic security modeling and
security event description export architecture.

The V2 patches and discusion around those can be found here:

https://lore.kernel.org/lkml/20230710102319.19716-1-greg@enjellic.com/T/#t

We have a rather significant upgrade to that patchset that we are
staging up for a V3 release.

The fundamental premise for TSEM is the encoding and modeling of the
parameters that describe LSM based security events.  It is designed to
be a model/policy agnostic scheme for generating attestations on the
state of the platform at large or a workload.  Workload models are
supported by a concept known as a security modeling namespace, much
like any other namespace, that tracks events for an isolated process
heirarchy.

The most important review comment on the V1 patchset, that can also be
found on lore, was by Greg Kroah-Hartmann who suggested using a
standardized encoding scheme like JSON for the event descriptions.  If
you look at his comments, he indicated that there is little rationale
for not using an encoding format that the entire technology industry
trusts and uses.

FWIW, we made the change to JSON and have never looked back, it was
the most positive review comment we received.

The current format would not seem to have any issues supporting IMA
style attestation.  For example, the most important event for IMA
would be a file open event.  Here is an example of the encoding
generated for that event:

{
    "event": {
        "process": "quixote",
        "type": "file_open",
        "ttd": "219",
        "p_ttd": "219",
        "task_id": "20e07b3614ee37869391849278dfe7285f37ec2362f7d10c052e6715ad888584",
        "p_task_id": "20e07b3614ee37869391849278dfe7285f37ec2362f7d10c052e6715ad888584",
        "ts": "6535350020298"
    },
    "COE": {
        "uid": "0",
        "euid": "0",
        "suid": "0",
        "gid": "0",
        "egid": "0",
        "sgid": "0",
        "fsuid": "0",
        "fsgid": "0",
        "capeff": "0x3ffffffffff"
    },
    "file_open": {
        "file": {
            "flags": "32800",
            "inode": {
                "uid": "50",
                "gid": "50",
                "mode": "0100755",
                "s_magic": "0xef53",
                "s_id": "xvda",
                "s_uuid": "feadbeaffeadbeaffeadbeaffeadbeaf"
            },
            "path": {
                "dev": {
                    "major": "202",
                    "minor": "0"
                },
                "pathname": "/opt/Quixote/sbin/runc"
            },
            "digest": "81f73a59be3d122ab484d7dfe9ddc81030f595cc59968f61c113a9a38a2c113a"
        }
    }
}

There is sufficient information included to track the digests of
executable files, or any other type of file for that matter, for any
user on the system.

This isn't an attempt to pitch TSEM, but rather to suggest the utility
of a self-describing JSON format for security logging.

As GKH correctly noted in his review comments, there is a great deal
of utility to be had by using a format that has significant and mature
userspace tooling support.  Our own work and deployments have also
indicated a great deal of utility to having log entries that are
self-describing.

One additional observation that may be of use with respect to anyone
pursueing an alternate event log format has come out of our data
science team.  They indicate there has been significant work in the
Elastic search community with respect to the development of
standardized descriptions of events for logging and other purposes,
reference the following URL:

https://www.elastic.co/guide/en/ecs/current/index.html

Our data team is looking at modifying our current security event
descriptions to be as consistent as possible with existing standards
for identifying event parameters.  Given that attestation and host
based security event modeling are only going to become more important
in the future, there would seem to be utility in working towards
contributing to standardized descriptions for security relevant logs.

Hopefully the above reflections are of assistance in furthering the
various agendas that are involved.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project


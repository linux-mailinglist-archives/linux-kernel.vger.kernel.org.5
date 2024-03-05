Return-Path: <linux-kernel+bounces-92827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3B87268E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C981F284C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AF3199B9;
	Tue,  5 Mar 2024 18:30:12 +0000 (UTC)
Received: from outbound23.service-now.com (outbound23.service-now.com [149.96.6.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A518C1A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.96.6.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663411; cv=none; b=GI/2WfMBFEhm4KQgtgbIPaqC50drdQ73+eM4tYgWwY5kilpbK92Zi9kwnd+KIs9a1zGSPJRh1g+rkVaihrYzKwCJxPLunfyMblhUwZDmXRQF4HsEI/LoaaSWiQTIXjXEdJB5vl7ETKnwqBeJ8a4yM7va433Fw5NnNpg0XvySmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663411; c=relaxed/simple;
	bh=RSjhyZieaHe3/J7/uivBZ3/+tR5GENiOPGAObg91P5Q=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=dyA80Z/QegzRY2Lds0T+d6ZwUrkK9W0M41MKX2a01SJxeQj0AMiIBE5Vzve9S2/cqM4c4DKa3diM7zgdB8sewqDv81d/XUycyE/9m6jzzn4Src+vSK34LUDtevKWh2vhJS2DjPheI1DZXk9ug86OhKFFnRhsROtte5iILGszNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=149.96.6.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from app142018.ycg3.service-now.com (unknown [10.248.3.236])
	by outbound23.service-now.com (Postfix) with ESMTP id 969EC421AF78;
	Tue,  5 Mar 2024 10:30:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 outbound23.service-now.com 969EC421AF78
Date: Tue, 5 Mar 2024 10:30:08 -0800 (PST)
From: Red Hat Product Security <secalert@redhat.com>
Reply-To: Red Hat Product Security <secalert@redhat.com>
To: security@suse.de, rfrohl@suse.de, cve@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Message-ID: <15436477.7601.1709663408600@app142018.ycg3.service-now.com>
Subject: Re: Re: CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7599_6887775.1709663408599"
X-ServiceNow-Source: Notification-ec04d32213ede300196f7e276144b04e
X-ServiceNow-SysEmail-Version: 2
Precedence: bulk
Auto-Submitted: auto-generated
X-ServiceNow-Generated: true

------=_Part_7599_6887775.1709663408599
Content-Type: multipart/alternative; 
	boundary="----=_Part_7600_23659363.1709663408600"

------=_Part_7600_23659363.1709663408600
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

Hello!

INC2885107 (Re: CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()) has been updated.

Opened for: rfrohl@suse.de
Followers: cve@kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, security@suse.de

Rohit Keshri updated your request with the following comments:

Hello Robert,
 Thank you for reaching to Red Hat Product Security.
 I have reviewed the flaws, CVE-2023-1192 has the correct patch used in the reference.
 Also, CVE-2023-52572 is a duplicate of CVE-2023-1192, which we will soon request for the same.
 I will also share some observation for CVE-2023-1192 while it us under investigation:
~~~
## TL;DR
 After CIFS transfers response data to system call, there is still a local variable points to the memory region, and if system call frees it faster than CIFS uses it, CIFS will access a free memory region when calls function such as `smb2_is_status_io_timeout()` .
 ## Detail
 When client uses CIFS, system calls about file operation will call cifs API to send samba request, and there is a CIFS kernel thread handler `cifs_demultiplex_thread()` which receives response from remote server and transfer those data to corresponding syscall request.
 In the beginning, CIFS kernel thread will allocate memory chunk to `server->smallbuf` in function `allocate_buffers()` and assign the pointer to local variable `buf` . Then cifs kernel thread will get a `struct mid_q_entry` instance from `server->ops->find_mid()` , this struct is used to transfer data between kernel thread and system call. Then cifs kernel thread calls `standard_receive3()` to receive response from server, saving data into `server->smallbuf`, assigning `server->smallbuf` to `mid_q_entry` instance `mids[0]`, and marking this `mid_q_entry` has been received response finally.
~~~
 Please let us know if there are any further queries on this please.
 Regards,
Rohit

How can I track and update my request?

To respond, reply to this email. You may also create a new email and include the request number (INC2885107) in the subject.

Thank you,
Product Security

Ref:MSG86263708
------=_Part_7600_23659363.1709663408600
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div><p style=3D"margin-top:0;margin-bottom:10px;"=
>Hello!</p><p style=3D"margin-top:0;margin-bottom:10px;">INC2885107 (Re: CV=
E-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()) has been updated.=
</p><p style=3D"margin-top:0;margin-bottom:10px;">Opened for:&nbsp;rfrohl@s=
use.de<br>Followers:&nbsp;cve@kernel.org, linux-kernel@vger.kernel.org, gre=
gkh@linuxfoundation.org, security@suse.de</p></div>
<p style=3D"margin-top: 10px; margin-bottom: 10px;">Rohit Keshri updated yo=
ur request with the following comments:</p>
<div style=3D"padding: 10px 0 10px 10px; background-color: ivory;"><div>Hel=
lo Robert,</div><div>&nbsp;</div><div>Thank you for reaching to Red Hat Pro=
duct Security.</div><div>&nbsp;</div><div>I have reviewed the flaws, CVE-20=
23-1192 has the correct patch used in the reference.</div><div>&nbsp;</div>=
<div>Also, CVE-2023-52572 is a duplicate of  CVE-2023-1192, which we will s=
oon request for the same.</div><div>&nbsp;</div><div>I will also share some=
 observation for CVE-2023-1192 while it us under investigation:</div><div>~=
~~</div><div>## TL;DR</div><div>&nbsp;</div><div>After CIFS transfers respo=
nse data to system call, there is still a local variable points to the memo=
ry region, and if system call frees it faster than CIFS uses it, CIFS will =
access a free memory region when calls function such as `smb2_is_status_io_=
timeout()` .</div><div>&nbsp;</div><div>## Detail</div><div>&nbsp;</div><di=
v>When client uses CIFS, system calls about file operation will call cifs A=
PI to send samba request, and there is a CIFS kernel thread handler `cifs_d=
emultiplex_thread()` which receives response from remote server and transfe=
r those data to corresponding syscall request.</div><div>&nbsp;</div><div>I=
n the beginning, CIFS kernel thread will allocate memory chunk to `server-&=
gt;smallbuf` in function `allocate_buffers()`  and assign the pointer to lo=
cal variable `buf` . Then cifs kernel thread will get a `struct mid_q_entry=
` instance from `server-&gt;ops-&gt;find_mid()` , this struct is used to tr=
ansfer data between kernel thread and system call. Then cifs kernel thread =
calls `standard_receive3()`  to receive response from server, saving data i=
nto `server-&gt;smallbuf`, assigning `server-&gt;smallbuf` to `mid_q_entry`=
 instance `mids[0]`, and marking this `mid_q_entry` has been received respo=
nse finally.</div><div>~~~</div><div>&nbsp;</div><div>Please let us know if=
 there are any further queries on this please.</div><div>&nbsp;</div><div>R=
egards,</div><div>Rohit</div></div>
<div><p style=3D"margin-top:20px;margin-bottom:10px;"><strong>How can I tra=
ck and update my request?</strong></p><p style=3D"margin-top:0;margin-botto=
m:10px;">To respond, reply to this email. You may also create a new email a=
nd include the request number (INC2885107) in the subject.</p></div>
<p style=3D"margin-top: 14px; margin-bottom: 0;">Thank you,<br>Product Secu=
rity</p><div>&nbsp;</div><div style=3D"display:inline">Ref:MSG86263708</div=
></body></html>
------=_Part_7600_23659363.1709663408600--

------=_Part_7599_6887775.1709663408599--


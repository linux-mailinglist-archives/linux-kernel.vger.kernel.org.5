Return-Path: <linux-kernel+bounces-143902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1650F8A3F49
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B90FB2164E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D156B6F;
	Sat, 13 Apr 2024 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixH/FfMQ"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC1E542
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045866; cv=none; b=Hd+ztKPMNYHjdvdhXOVBlyJkHPXtxI4beGOqBhR8+1xOwUESeY6QqCVc12EMiic7gA+65Ly1SRr4OTVzuiiphx4DanNBoEsX4ekeslqvAwsviXZR69ZbI93ls8FUcG2TAROAMIMyeaWuMaXnSRE7b/QyWrqJSQ8bUEjCVzIrkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045866; c=relaxed/simple;
	bh=lAsvDgwH7jpTKFiJX27S3PISwwa6qiMN0qj5ChnlPJs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tjpMufc79/aSCyuEY6dd3jGTN2B90Xr7AQNTaNLyNO37MeVD/2ek/0PKAnCUGTaU2mPZ18m+5eBkkWO4/a8VU0nq/HjqvSc1qzbkdttFo+uU4pQJCPhamIq7/doS2hA588MeR4iPS/4Eu++xArHkZXtnFGKoUfx6Ur4ggAyPuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixH/FfMQ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb77e56b20so201712a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713045864; x=1713650664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lAsvDgwH7jpTKFiJX27S3PISwwa6qiMN0qj5ChnlPJs=;
        b=ixH/FfMQkUBOhSDMRyzeDUAr9SU6yREHKPeAMz/X99VTXA4rxluN/CAnl94ESx5GHD
         HQHXDLmYZh1tRDwI0qvyxNalgzsczXt9IdfWr4AbgL7kZJkLwm5hSMMkDduHjTYoKIjm
         aq2sF3uXROKx7sn2QQAOOpgqxlrDaSRuWXnyHPhL8cAxW4ydxVf2hdDcQpbVfPPDZUsw
         GjFEv2rNvOueH5N9QI9jFkSrylrBzK9cKw+6xYU2nxIn5mciXbnW0phtKl/2cyJDZcWI
         tgPrXkOs/3EIzG+90UWW/373+Js5oKOwfrTCUMXgOEYgU2ymEOrgmlpgEtyBWwY2FUPf
         E2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045864; x=1713650664;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAsvDgwH7jpTKFiJX27S3PISwwa6qiMN0qj5ChnlPJs=;
        b=i2v62vDJrVcPuh9z794elQFTeCPZ6HcbrDCp5Kd0BHTckt+XIo977mQgTZ/CrE5oMY
         uevC432iugH+2k/GbAmfIYe+opROUfbDlauj53IHKzxtcErL1FFcODOCrkBKuXzjj0F/
         8HBn6HMa+I25i4W1RRgUAkyjTJVQyoH9v9HAJAiKEa/WL3TVlvP7Y1gLbqHPcBzP4o99
         svGVS3wPaknDgTAOHiJ7OPbkr+76gBRpOCl0Q4pe9TtTrPuGoGp0fzZSEBV6NCa1H8lo
         Cb6S5i1UfGCr73L7Lsl5G8Mhwro5zqe0WKB/IaZNPY8bDiefXiuvGFDjrkWW1wqjLbo5
         0W/A==
X-Forwarded-Encrypted: i=1; AJvYcCUby36CLj9jfu1esajZj+ZF7h3al1hYDSfR4AGEvKy9h7YDphYnFQgg37hiv2fQ9wTFshbYw5dPv7eh9gzx8kUu8W7x3LLuXy0ifaSi
X-Gm-Message-State: AOJu0Yw+3+hGm8KiQnH8z4JPDMgki55+l8RzFAJhwKgPqOYj9UyEYe2E
	FIBQga2+Z38eaev8z9udTyHn3b9bxekewWjBS1IhfgCUYpJVe+WG23xGDAun1s98zoO0lfFCD+s
	bnDa4VTGE8EPAjGDLOM5deKP46JdIvZdhdCI=
X-Google-Smtp-Source: AGHT+IFtwPQCQNLqkWqwx1jJZM7MCOK/UfGK0+fNpWffbDwMUnJa6NvoE0OmF+lGBZ0HSOUyiVQvJPWECEWobjod7o8=
X-Received: by 2002:a05:6808:4d2:b0:3c7:999:f5e4 with SMTP id
 a18-20020a05680804d200b003c70999f5e4mr962424oie.5.1713045863845; Sat, 13 Apr
 2024 15:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Wagner <ewagner12@gmail.com>
Date: Sat, 13 Apr 2024 18:04:12 -0400
Message-ID: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
Subject: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000336c8f06160192d6"

--000000000000336c8f06160192d6
Content-Type: multipart/alternative; boundary="000000000000336c8e06160192d4"

--000000000000336c8e06160192d4
Content-Type: text/plain; charset="UTF-8"

On my Thinkpad T14s G3 AMD (Ryzen 7 6850U) laptop connected to an AMD RX
580 in Akitio Node Thunderbolt 3 eGPU. Booting with the eGPU connected
hangs on kernels 6.7 and 6.8, but worked on 6.6. For debugging, I find that
adding the kernel parameter amd_iommu=off seems to fix the issue and allows
booting with the eGPU on 6.7.

I tried bisecting the issue between 6.6 and 6.7 and ended up with:
"e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2 is the first bad commit" in the
attached. This seems to indicate an amd iommu issue.

Two others also reported the same issue on AMD Ryzen 7 7840 with AMD RX
6000 connected as eGPU (https://gitlab.freedesktop.org/drm/amd/-/issues/3182
).

Let me know if you need more information.

--000000000000336c8e06160192d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>On my Thinkpad T14s G3 AMD (Ryzen 7 6850U) laptop con=
nected to an AMD RX 580 in Akitio Node Thunderbolt 3 eGPU. Booting with the=
 eGPU connected hangs on kernels 6.7 and 6.8, but worked on 6.6. For debugg=
ing, I find that adding the kernel parameter amd_iommu=3Doff seems to fix t=
he issue and allows booting with the eGPU on 6.7.</div><div><br></div>I tri=
ed bisecting the issue between 6.6 and 6.7 and ended up with: &quot;e8cca46=
6a84a75f8ff2a7a31173c99ee6d1c59d2 is the first bad commit&quot; in the atta=
ched. This seems to indicate an amd iommu issue.<br><br><div>Two others als=
o reported the same issue on AMD Ryzen 7 7840 with AMD RX 6000 connected as=
 eGPU (<a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/3182">htt=
ps://gitlab.freedesktop.org/drm/amd/-/issues/3182</a>).</div><div><br></div=
><div>Let me know if you need more information.<br></div></div>

--000000000000336c8e06160192d4--
--000000000000336c8f06160192d6
Content-Type: text/x-log; charset="US-ASCII"; name="bisect.log"
Content-Disposition: attachment; filename="bisect.log"
Content-Transfer-Encoding: base64
Content-ID: <f_luyn1b3d0>
X-Attachment-Id: f_luyn1b3d0

QmlzZWN0aW5nOiAzNjYgcmV2aXNpb25zIGxlZnQgdG8gdGVzdCBhZnRlciB0aGlzIChyb3VnaGx5
IDkgc3RlcHMpCls3NGU5MzQ3ZWJjNWJlNDUyOTM1ZmU0ZjNlZGRiMTUwYWE1YTZmNGZlXSBNZXJn
ZSB0YWcgJ2xvb25nYXJjaC1maXhlcy02LjYtMycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2NoZW5odWFjYWkvbGludXgtbG9vbmdzb24KQmlzZWN0aW5n
OiAxODIgcmV2aXNpb25zIGxlZnQgdG8gdGVzdCBhZnRlciB0aGlzIChyb3VnaGx5IDggc3RlcHMp
CltmNjE3NjQ3MTU0MmQ5OTExMzc1NDNhZjJlZjFjMThkYWUzMjg2MDc5XSBNZXJnZSB0YWcgJ210
ZC9maXhlcy1mb3ItNi42LXJjNycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L210ZC9saW51eApCaXNlY3Rpbmc6IDg3IHJldmlzaW9ucyBsZWZ0IHRvIHRl
c3QgYWZ0ZXIgdGhpcyAocm91Z2hseSA3IHN0ZXBzKQpbZmUzY2ZlODY5ZDVlMDQ1Mzc1NGNmMmI0
Yzc1MTEwMjc2YjVlODUyN10gTWVyZ2UgdGFnICdwaHktZml4ZXMtNi42JyBvZiBnaXQ6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcGh5L2xpbnV4LXBoeQpCaXNlY3Rp
bmc6IDQzIHJldmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIgdGhpcyAocm91Z2hseSA2IHN0ZXBz
KQpbYzc2YzA2N2U0ODhjY2Q1NTczNGMzZTc1MDc5OWNhZjJjNTk1NmRiNl0gczM5MC9wY2k6IFVz
ZSBkbWEtaW9tbXUgbGF5ZXIKQmlzZWN0aW5nOiAyNyByZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFm
dGVyIHRoaXMgKHJvdWdobHkgNSBzdGVwcykKW2FhNWNhYmM0Y2U4ZTZiNDVkMTcwZDE2MmRjNTRi
MWJhYzE3NjdjNDddIE1lcmdlIHRhZyAnYXJtLXNtbXUtdXBkYXRlcycgb2YgZ2l0Oi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3dpbGwvbGludXggaW50byBhcm0vc21t
dQpCaXNlY3Rpbmc6IDE0IHJldmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIgdGhpcyAocm91Z2hs
eSA0IHN0ZXBzKQpbYmJjNzBlMGFlYzI4N2UxNjQzNDRiMWEwNzFiZDQ2NDY2YTRmMjliM10gaW9t
bXUvZGFydDogUmVtb3ZlIHRoZSBmb3JjZV9ieXBhc3MgdmFyaWFibGUKQmlzZWN0aW5nOiA5IHJl
dmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIgdGhpcyAocm91Z2hseSAzIHN0ZXBzKQpbZTgyYzE3
NWU2MzIyOWVhNDk1YTBhMGI1MzA1YTk4YjViNmVlNTM0Nl0gUmV2ZXJ0ICJpb21tdS92dC1kOiBS
ZW1vdmUgdW51c2VkIGZ1bmN0aW9uIgpCaXNlY3Rpbmc6IDUgcmV2aXNpb25zIGxlZnQgdG8gdGVz
dCBhZnRlciB0aGlzIChyb3VnaGx5IDIgc3RlcHMpCls5MmJjZTk3ZjBjMzQxZDMwMzdiMGYzNjRi
NjgzOTQ4M2Y2YTQxY2FlXSBzMzkwL3BjaTogRml4IHJlc2V0IG9mIElPTU1VIHNvZnR3YXJlIGNv
dW50ZXJzCkJpc2VjdGluZzogMyByZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJv
dWdobHkgMiBzdGVwcykKWzM2MTMwNDcyODBlYzQyYTRlMTM1MGZkYzFhNmRkMTYxZmY0MDA4Y2Nd
IE1lcmdlIHRhZyAndjYuNi1yYzcnIGludG8gY29yZQpCaXNlY3Rpbmc6IDIgcmV2aXNpb25zIGxl
ZnQgdG8gdGVzdCBhZnRlciB0aGlzIChyb3VnaGx5IDEgc3RlcCkKW2Y3ZGE5YzA4MTUxN2RhYmE3
MGY5ZjkzNDJlMDlkN2E2MzIyYmEzMjNdIGlvbW11L3RlZ3JhLXNtbXU6IERyb3AgdW5uZWNlc3Nh
cnkgZXJyb3IgY2hlY2sgZm9yIGZvciBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKQpCaXNlY3Rpbmc6IDEg
cmV2aXNpb24gbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgMSBzdGVwKQpbOWUxM2Vj
NjFkZTJhNTExOTViMTIyYTc5NDYxNDMxZDhjYjk5ZDdiNV0gaW9tbXUvdmlydGlvOiBBZGQgX19j
b3VudGVkX2J5IGZvciBzdHJ1Y3QgdmlvbW11X3JlcXVlc3QgYW5kIHVzZSBzdHJ1Y3Rfc2l6ZSgp
CkJpc2VjdGluZzogMCByZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkg
MCBzdGVwcykKWzZlNmM2ZDZiYzZjOTZjMjQ3N2RkZmVhMjRhMTIxZWI1ZWUxMmI3YTNdIGlvbW11
OiBBdm9pZCB1bm5lY2Vzc2FyeSBjYWNoZSBpbnZhbGlkYXRpb25zCmU4Y2NhNDY2YTg0YTc1Zjhm
ZjJhN2EzMTE3M2M5OWVlNmQxYzU5ZDIgaXMgdGhlIGZpcnN0IGJhZCBjb21taXQKY29tbWl0IGU4
Y2NhNDY2YTg0YTc1ZjhmZjJhN2EzMTE3M2M5OWVlNmQxYzU5ZDIKTWVyZ2U6IDZlNmM2ZDZiYzYg
ZjdkYTljMDgxNSBhYTVjYWJjNGNlIDllMTNlYzYxZGUgZTgyYzE3NWU2MyBjZWRjODExYzc2IDM2
MTMwNDcyODAgOTJiY2U5N2YwYwpBdXRob3I6IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRl
PgpEYXRlOiAgIEZyaSBPY3QgMjcgMDk6MTM6NDAgMjAyMyArMDIwMAoKICAgIE1lcmdlIGJyYW5j
aGVzICdpb21tdS9maXhlcycsICdhcm0vdGVncmEnLCAnYXJtL3NtbXUnLCAndmlydGlvJywgJ3g4
Ni92dC1kJywgJ3g4Ni9hbWQnLCAnY29yZScgYW5kICdzMzkwJyBpbnRvIG5leHQKCiBEb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCAgICB8ICAgOSArLQogLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvYXJtLHNtbXUueWFtbCAgICAgICAgfCAgIDIgKwog
YXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcgICAgICAgICAgICAgICAgfCAgIDEg
LQogYXJjaC9hcm0vY29uZmlncy90ZWdyYV9kZWZjb25maWcgICAgICAgICAgICAgICAgICAgfCAg
IDEgLQogYXJjaC9wb3dlcnBjL2tlcm5lbC9pb21tdS5jICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNTMgKy0KIGFyY2gvczM5MC9pbmNsdWRlL2FzbS9wY2kuaCAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDExIC0KIGFyY2gvczM5MC9pbmNsdWRlL2FzbS9wY2lfY2xwLmggICAgICAgICAgICAg
ICAgICAgIHwgICAzICsKIGFyY2gvczM5MC9pbmNsdWRlL2FzbS9wY2lfZG1hLmggICAgICAgICAg
ICAgICAgICAgIHwgMTIxICstLQogYXJjaC9zMzkwL3BjaS9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDIgKy0KIGFyY2gvczM5MC9wY2kvcGNpLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDM1ICstCiBhcmNoL3MzOTAvcGNpL3BjaV9idXMuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgNSAtCiBhcmNoL3MzOTAvcGNpL3BjaV9kZWJ1Zy5j
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArLQogYXJjaC9zMzkwL3BjaS9wY2lfZG1h
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA3NDYgLS0tLS0tLS0tLS0tLS0tCiBhcmNo
L3MzOTAvcGNpL3BjaV9ldmVudC5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNyArLQog
YXJjaC9zMzkwL3BjaS9wY2lfc3lzZnMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTkg
Ky0KIGRyaXZlcnMvaW9tbXUvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDE1ICstCiBkcml2ZXJzL2lvbW11L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMSAtCiBkcml2ZXJzL2lvbW11L2FtZC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgOSAtCiBkcml2ZXJzL2lvbW11L2FtZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMSAtCiBkcml2ZXJzL2lvbW11L2FtZC9hbWRfaW9tbXUuaCAgICAgICAgICAg
ICAgICAgICAgICB8ICAzNSArLQogZHJpdmVycy9pb21tdS9hbWQvYW1kX2lvbW11X3R5cGVzLmgg
ICAgICAgICAgICAgICAgfCAgNTIgKy0KIGRyaXZlcnMvaW9tbXUvYW1kL2luaXQuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMTE3ICstLQogZHJpdmVycy9pb21tdS9hbWQvaW9fcGd0YWJs
ZV92Mi5jICAgICAgICAgICAgICAgICAgfCAgIDggKy0KIGRyaXZlcnMvaW9tbXUvYW1kL2lvbW11
LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNTc3ICsrKysrLS0tLS0tLQogZHJpdmVycy9p
b21tdS9hbWQvaW9tbXVfdjIuYyAgICAgICAgICAgICAgICAgICAgICAgfCA5OTYgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCiBkcml2ZXJzL2lvbW11L2FwcGxlLWRhcnQuYyAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDEzOCArLS0KIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLXN2YS5jICAgIHwgIDcxICstCiBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0t
c21tdS12My5jICAgICAgICB8IDI1MSArKystLS0KIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
LXYzL2FybS1zbW11LXYzLmggICAgICAgIHwgIDE3ICstCiBkcml2ZXJzL2lvbW11L2FybS9hcm0t
c21tdS9hcm0tc21tdS1xY29tLmMgICAgICAgICB8ICAgMiArCiBkcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS9xY29tX2lvbW11LmMgICAgICAgICAgICB8ICA0NSArLQogZHJpdmVycy9pb21tdS9k
bWEtaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyMDAgKysrKy0KIGRyaXZlcnMv
aW9tbXUvZXh5bm9zLWlvbW11LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDgzICstCiBkcml2
ZXJzL2lvbW11L2ZzbF9wYW11X2RvbWFpbi5jICAgICAgICAgICAgICAgICAgICB8ICA0MSArLQog
ZHJpdmVycy9pb21tdS9pbnRlbC9kZWJ1Z2ZzLmMgICAgICAgICAgICAgICAgICAgICAgfCAyMTUg
KysrKy0KIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDE5ICstCiBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmggICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxNCArCiBkcml2ZXJzL2lvbW11L2lvbW11LmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDQ1NSArKysrKy0tLS0tCiBkcml2ZXJzL2lvbW11L2lvbW11ZmQvc2VsZnRlc3Qu
YyAgICAgICAgICAgICAgICAgICB8ICAzMCArLQogZHJpdmVycy9pb21tdS9pb3ZhLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgOTUgKy0KIGRyaXZlcnMvaW9tbXUvaXBtbXUtdm1z
YS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDcyICstCiBkcml2ZXJzL2lvbW11L21zbV9p
b21tdS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzNSArLQogZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzUgKy0KIGRyaXZlcnMvaW9t
bXUvbXRrX2lvbW11X3YxLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDI4ICstCiBkcml2ZXJz
L2lvbW11L29tYXAtaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2OSArLQogZHJp
dmVycy9pb21tdS9vbWFwLWlvbW11LmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0K
IGRyaXZlcnMvaW9tbXUvcm9ja2NoaXAtaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgIHwgIDU5
ICstCiBkcml2ZXJzL2lvbW11L3MzOTAtaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8
IDQyNCArKysrKysrKy0KIGRyaXZlcnMvaW9tbXUvc3ByZC1pb21tdS5jICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDM2ICstCiBkcml2ZXJzL2lvbW11L3N1bjUwaS1pb21tdS5jICAgICAgICAg
ICAgICAgICAgICAgICB8ICA4MCArLQogZHJpdmVycy9pb21tdS90ZWdyYS1nYXJ0LmMgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAzNzEgLS0tLS0tLS0KIGRyaXZlcnMvaW9tbXUvdGVncmEtc21t
dS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDU4ICstCiBkcml2ZXJzL2lvbW11L3ZpcnRp
by1pb21tdS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQogZHJpdmVycy9tZW1vcnkv
dGVncmEvbWMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzQgLQogZHJpdmVycy9tZW1v
cnkvdGVncmEvdGVncmEyMC5jICAgICAgICAgICAgICAgICAgICAgfCAgMjggLQogaW5jbHVkZS9s
aW51eC9hbWQtaW9tbXUuaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMjAgLS0tCiBpbmNs
dWRlL2xpbnV4L2lvbW11LmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzOCArLQog
aW5jbHVkZS9zb2MvdGVncmEvbWMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjYg
LQogNTggZmlsZXMgY2hhbmdlZCwgMjEzOCBpbnNlcnRpb25zKCspLCAzOTA1IGRlbGV0aW9ucygt
KQogZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvczM5MC9wY2kvcGNpX2RtYS5jCiBkZWxldGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9pb21tdS9hbWQvaW9tbXVfdjIuYwogZGVsZXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvaW9tbXUvdGVncmEtZ2FydC5jCg==
--000000000000336c8f06160192d6--


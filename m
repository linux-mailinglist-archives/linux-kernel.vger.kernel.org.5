Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2097AA5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjIVAH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIVAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:07:26 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15006102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:07:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d776e1f181bso1908789276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695341239; x=1695946039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCoAFKgoNTRb7SqWTYs4lvzjZ7gnG1PcVrDLMhXRbWQ=;
        b=a/yw0xDwFA2MxAd4gDEBnQ5C3JLsTkfmMBGHMcHNpJt8o4e+6AFeVxJUXZNUHqOT2T
         4Z6W/iojqbivOMX5kuPWsirOkq7qsH0/qFHRq49s96Dfd9UH+vLfxZsJznIiZv5Ffzjx
         aud8JXxJtp0hiyPiSiBIL0G/jAlLVFxDEnjkyBO1alRfhUmnSVhQ/rhUheX2j5LUUglg
         ArPNClMh1EGcmxwHn1BEQ6R/1wQjJlMlCMYg9x0gfWGC6lLUPKWxsFwzIUvI/BPV5wkn
         CmnRwdK6m0SqWWviOCevOTbH22KIHo2UjyF8vnYxjlST5O/4tdhOa48UsV7pPFM//0zq
         migg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695341239; x=1695946039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCoAFKgoNTRb7SqWTYs4lvzjZ7gnG1PcVrDLMhXRbWQ=;
        b=bA0EJ/0BQTorVbNZxjvutqNIb+CCQCmv6IZtTQqAPNMrhCAB+DLe3tHH8JgKPx8LcJ
         1UVkoVVeiJ7V/BFClfXIkdjQFyP6dQGMWJZrh0f/1oNYLVulCOkqmOrJ1J4zCbEwtsuk
         cjp+m8j9PS3fyaV4y2HEgOixBLFm5UqeMxPNoD+utgMeenxujI6MA/pq1fS3F/OybykY
         dYm4/kGn5/9SjNAuWIVx6QBKlelYG8cwI4wYUfD5OfM1qlDeq6f8qD+eN1VAjfL+vAMS
         fQCaZt+T1986B2Bp4czmi8czs6fCY4RjVrlq8sjsqeh5zaU8nLp/Ls7+1KKrfcLrjN85
         kzlw==
X-Gm-Message-State: AOJu0YxzMqBee+1o2uRW8Pj3Y43PFwZUMBucUlMkuOGJRHNw8YFvPZWO
        SNWJfxNWn2Lx8An5IoQW5/ipYBabJg7UOXU/n/adEA==
X-Google-Smtp-Source: AGHT+IFs59DEMcpeIrcuBoEwl0eYmI077WfvfD2WVHYXAqMuqJ5cPG0WDWNE3cAxARtTroBcGPxQWy3g6Za+ilJdnps=
X-Received: by 2002:a25:84cc:0:b0:d80:57d0:e56d with SMTP id
 x12-20020a2584cc000000b00d8057d0e56dmr7177817ybm.38.1695341239011; Thu, 21
 Sep 2023 17:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230915172818.761-1-shiju.jose@huawei.com> <20230915172818.761-3-shiju.jose@huawei.com>
In-Reply-To: <20230915172818.761-3-shiju.jose@huawei.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Thu, 21 Sep 2023 17:07:04 -0700
Message-ID: <CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
To:     shiju.jose@huawei.com, "Luck, Tony" <tony.luck@intel.com>,
        dave.hansen@linux.intel.com, jon.grimm@amd.com,
        vilas.sridharan@amd.com, David Rientjes <rientjes@google.com>
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        naoya.horiguchi@nec.com, james.morse@arm.com, david@redhat.com,
        jthoughton@google.com, somasundaram.a@hpe.com,
        erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
        mike.malvestuto@intel.com, gthelen@google.com, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:29=E2=80=AFAM <shiju.jose@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Add sysfs documentation entries for the set of attributes those are
> exposed in /sys/class/scrub/ by the scrub driver. These attributes
> support configuring parameters of a scrub device.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  .../ABI/testing/sysfs-class-scrub-configure   | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
>
> diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Docu=
mentation/ABI/testing/sysfs-class-scrub-configure
> new file mode 100644
> index 000000000000..347e2167dc62
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
> @@ -0,0 +1,82 @@
> +What:          /sys/class/scrub/
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               The scrub/ class subdirectory belongs to the
> +               scrubber subsystem.
> +
> +What:          /sys/class/scrub/scrubX/
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               The /sys/class/scrub/scrub{0,1,2,3,...} directories

This API (sysfs interface) is very specific to the ACPI interface
defined for hardware patrol scrubber. I wonder can we have some
interface that is more generic, for a couple of reasons:

1. I am not aware of any chip/platform hardware that implemented the
hw ps part defined in ACPI RASF/RAS2 spec. So I am curious what the
RAS experts from different hardware vendors think about this. For
example, Tony and Dave from Intel, Jon and Vilas from AMD. Is there
any hardware platform (if allowed to disclose) that implemented ACPI
RASF/RAS2? If so, will vendors continue to support the control of
patrol scrubber using the ACPI spec? If not (as Tony said in [1], will
the vendor consider starting some future platform?

If we are unlikely to get the vendor support, creating this ACPI
specific sysfs API (and the driver implementations) in Linux seems to
have limited meaning.

> +               correspond to each scrub device.
> +
> +What:          /sys/class/scrub/scrubX/name
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RO) name of the memory scrub device
> +
> +What:          /sys/class/scrub/scrubX/regionY/

2. I believe the concept of "region" here is probably from
PATROL_SCRUB defined in =E2=80=9CAPCI section 5.2.20.5. Parameter Block". I=
t
is indeed powerful: if a process's physical memory spans over multiple
memory controllers, OS can in theory scrub chunks of the memory
belonging to the process. However, from a previous discussion [1],
"From a h/w perspective it might always be complex". IIUC, the address
translation from physical address to channel address is hard to
achieve, and probably that's one of the tech reasons the patrol scrub
ACPI spec is not in practice implemented?

So my take is, control at the granularity of the memory controller is
probably a nice compromise. Both OS and userspace can get a pretty
decent amount of flexibility, start/stop/adjust speed of the scrubbing
on a memory controller; meanwhile it doesn't impose too much pain to
hardware vendors when they provide these features in hardware. In
terms of how these controls/features will be implemented, I imagine it
could be implemented:
* via hardware registers that directly or indirectly control on memory
controllers
* via ACPI if the situation changes in 10 years (and the RASF/RAS2/PCC
drivers implemented in this patchset can be directly plugged into)
* a kernel-thread that uses cpu read to detect memory errors, if
hardware support is unavailable or not good enough

Given these possible backends of scrubbing, I think a more generic
sysfs API that covers and abstracts these backends will be more
valuable right now. I haven=E2=80=99t thought thoroughly, but how about
defining the top-level interface as something like
=E2=80=9C/sys/devices/system/memory_controller_scrubX/=E2=80=9D, or
=E2=80=9C/sys/class/memory_controllerX/scrub=E2=80=9D?

[1] https://lore.kernel.org/linux-mm/SJ1PR11MB6083BF93E9A88E659CED5EC4FC3F9=
@SJ1PR11MB6083.namprd11.prod.outlook.com/T/#m13516ee35caa05b506080ae805bee1=
4f9f958d43

> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               The /sys/class/scrub/scrubX/region{0,1,2,3,...}
> +               directories correspond to each scrub region under a scrub=
 device.
> +               Scrub region is a physical address range for which scrub =
may be
> +               separately controlled. Regions may overlap in which case =
the
> +               scrubbing rate of the overlapped memory will be at least =
that
> +               expected due to each overlapping region.
> +
> +What:          /sys/class/scrub/scrubX/regionY/addr_base
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RW) The base of the address range of the memory region
> +               to be patrol scrubbed.
> +               On reading, returns the base of the memory region for
> +               the actual address range(The platform calculates
> +               the nearest patrol scrub boundary address from where
> +               it can start scrubbing).
> +
> +What:          /sys/class/scrub/scrubX/regionY/addr_size
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RW) The size of the address range to be patrol scrubbed.
> +               On reading, returns the size of the memory region for
> +               the actual address range.
> +
> +What:          /sys/class/scrub/scrubX/regionY/enable
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (WO) Start/Stop scrubbing the memory region.
> +               1 - enable the memory scrubbing.
> +               0 - disable the memory scrubbing..
> +
> +What:          /sys/class/scrub/scrubX/regionY/speed_available
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RO) Supported range for the partol speed(scrub rate)
> +               by the scrubber for a memory region.
> +               The unit of the scrub rate vary depends on the scrubber.
> +
> +What:          /sys/class/scrub/scrubX/regionY/speed
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RW) The partol speed(scrub rate) on the memory region sp=
ecified and
> +               it must be with in the supported range by the scrubber.
> +               The unit of the scrub rate vary depends on the scrubber.
> --
> 2.34.1
>
>

Return-Path: <linux-kernel+bounces-4691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3CC8180A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B2C285112
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF2A5C97;
	Tue, 19 Dec 2023 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWMFrUUT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63668BE1;
	Tue, 19 Dec 2023 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b9e2a5e8faso1690851b6e.1;
        Mon, 18 Dec 2023 20:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702960943; x=1703565743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wN82s6T7Bz2Zpf2akZr11znIoaGa6mjatH3NjUqmpo=;
        b=NWMFrUUTL4buomgfB1Idk1KYK0Cc19m4lhiT01rI70bjvU78fZ0ElkUtpk/piNDq0o
         gYyOlbjgXHzLnKISjFqJ35ZcPt0EOi99llTS2cBxISI3z4MvYKxoDN08/vK+WxrgKCTN
         jg9AcdPnSk95Caf2epqtDyo4qzcI4ue+tIl65CtXQFJYcq9GVR34dnPA0GeR+rfQJ0Td
         wBaPYbU9xEK1OAvKmyRiLHXRs7ySdcmMHkFyMoVz5k6c5Vx/HTaNUvltfRjejkpv6Ht6
         TI1OanbPLCX2s+zFuEnYWLyFQVFsZ7Cky68+Ug+8IbscKdnfK+IFSo050UgIO8/KOfRH
         W5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702960943; x=1703565743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wN82s6T7Bz2Zpf2akZr11znIoaGa6mjatH3NjUqmpo=;
        b=BlgF3xJ+RE0B9AmjXx3U4KV0Rmt01Byxgu0x+tc5EJUyFyu1fUWvNjF5Zkmb0Pummj
         cVUMWi8p85nAXDpwvCZ0JcjaA1OOCvspa5Vtz4IT9nt8akkFSyU/e5/yUiILNjKk0fxO
         OTqqRF9VPhwwBl/vzdqlwAjLlJwBjhWNsZDRcoi6hfuqwfR4welIKLLOjgw45iV3Etqn
         t0Zl63dm7hs1tXtlPLccS8A/SI2HyS0nQsksfS23t5tsGvHyfCboZXT0heYE4kk5C7ay
         dfI3lSN9vXHDUn0513e0bDPJ17KZYpdQcY13SbS2V9S+xD8Iaa3L6t6efxpaEp+D9XAq
         X42g==
X-Gm-Message-State: AOJu0YyaSShgpHfS/S9nwvvE8dR05jvjZAZwnsuRIkf02cFTdW2o0pfT
	OmcEYTYUFJxBOe5tbPXp+SRRCMVF1fKalFud4HU=
X-Google-Smtp-Source: AGHT+IFRoK/gRPTT7EGwCxV0Fruup0O1I3mKRHx+ackgZZ7TnJzwdG7a9Pd0Cupd7eZcTCB9zJDz8LEwX5FRT3qCFPI=
X-Received: by 2002:a05:6808:a11:b0:3b9:e52e:da33 with SMTP id
 n17-20020a0568080a1100b003b9e52eda33mr175699oij.7.1702960942831; Mon, 18 Dec
 2023 20:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129110853.94344-1-lukasz.luba@arm.com> <20231129110853.94344-24-lukasz.luba@arm.com>
In-Reply-To: <20231129110853.94344-24-lukasz.luba@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 19 Dec 2023 12:42:12 +0800
Message-ID: <CAB8ipk_BmdOYWKo_b7g=e6LJVyt1=Yo=wuG5dvUtTvNnmCw+Zg@mail.gmail.com>
Subject: Re: [PATCH v5 23/23] Documentation: EM: Update with runtime
 modification design
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com, 
	amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 7:11=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Add a new section 'Design' which covers the information about Energy
> Model. It contains the design decisions, describes models and how they
> reflect the reality. Remove description of the default EM. Change the
> other section IDs. Add documentation bit for the new feature which
> allows to modify the EM in runtime.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/power/energy-model.rst | 206 +++++++++++++++++++++++++--
>  1 file changed, 196 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/e=
nergy-model.rst
> index 13225965c9a4..1f8cf36914b1 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -72,16 +72,48 @@ required to have the same micro-architecture. CPUs in=
 different performance
>  domains can have different micro-architectures.
>
>
> -2. Core APIs
> +2. Design
> +-----------------
> +
> +2.1 Runtime modifiable EM
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +To better reflect power variation due to static power (leakage) the EM
> +supports runtime modifications of the power values. The mechanism relies=
 on
> +RCU to free the modifiable EM perf_state table memory. Its user, the tas=
k
> +scheduler, also uses RCU to access this memory. The EM framework provide=
s
> +API for allocating/freeing the new memory for the modifiable EM table.
> +The old memory is freed automatically using RCU callback mechanism when =
there
> +are no owners anymore for the given EM runtime table instance. This is t=
racked
> +using kref mechanism. The device driver which provided the new EM at run=
time,
> +should call EM API to free it safely when it's no longer needed. The EM
> +framework will handle the clean-up when it's possible.
> +
> +The kernel code which want to modify the EM values is protected from con=
current
> +access using a mutex. Therefore, the device driver code must run in slee=
ping
> +context when it tries to modify the EM.
> +
> +With the runtime modifiable EM we switch from a 'single and during the e=
ntire
> +runtime static EM' (system property) design to a 'single EM which can be
> +changed during runtime according e.g. to the workload' (system and workl=
oad
> +property) design.
> +
> +It is possible also to modify the CPU performance values for each EM's
> +performance state. Thus, the full power and performance profile (which
> +is an exponential curve) can be changed according e.g. to the workload
> +or system property.
> +
> +
> +3. Core APIs
>  ------------
>
> -2.1 Config options
> +3.1 Config options
>  ^^^^^^^^^^^^^^^^^^
>
>  CONFIG_ENERGY_MODEL must be enabled to use the EM framework.
>
>
> -2.2 Registration of performance domains
> +3.2 Registration of performance domains
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>  Registration of 'advanced' EM
> @@ -110,8 +142,8 @@ The last argument 'microwatts' is important to set wi=
th correct value. Kernel
>  subsystems which use EM might rely on this flag to check if all EM devic=
es use
>  the same scale. If there are different scales, these subsystems might de=
cide
>  to return warning/error, stop working or panic.
> -See Section 3. for an example of driver implementing this
> -callback, or Section 2.4 for further documentation on this API
> +See Section 4. for an example of driver implementing this
> +callback, or Section 3.4 for further documentation on this API
>
>  Registration of EM using DT
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -156,7 +188,7 @@ The EM which is registered using this method might no=
t reflect correctly the
>  physics of a real device, e.g. when static power (leakage) is important.
>
>
> -2.3 Accessing performance domains
> +3.3 Accessing performance domains
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>  There are two API functions which provide the access to the energy model=
:
> @@ -175,10 +207,83 @@ CPUfreq governor is in use in case of CPU device. C=
urrently this calculation is
>  not provided for other type of devices.
>
>  More details about the above APIs can be found in ``<linux/energy_model.=
h>``
> -or in Section 2.4
> +or in Section 3.5
> +
> +
> +3.4 Runtime modifications
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Drivers willing to update the EM at runtime should use the following ded=
icated
> +function to allocate a new instance of the modified EM. The API is liste=
d
> +below::
> +
> +  struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *p=
d);
> +
> +This allows to allocate a structure which contains the new EM table with
> +also RCU and kref needed by the EM framework. The 'struct em_perf_table'
> +contains array 'struct em_perf_state state[]' which is a list of perform=
ance
> +states in ascending order. That list must be populated by the device dri=
ver
> +which wants to update the EM. The list of frequencies can be taken from
> +existing EM (created during boot). The content in the 'struct em_perf_st=
ate'
> +must be populated by the driver as well.
> +
> +This is the API which does the EM update, using RCU pointers swap::
> +
> +  int em_dev_update_perf_domain(struct device *dev,
> +                       struct em_perf_table __rcu *new_table);
> +
> +Drivers must provide a pointer to the allocated and initialized new EM
> +'struct em_perf_table'. That new EM will be safely used inside the EM fr=
amework
> +and will be visible to other sub-systems in the kernel (thermal, powerca=
p).
> +The main design goal for this API is to be fast and avoid extra calculat=
ions
> +or memory allocations at runtime. When pre-computed EMs are available in=
 the
> +device driver, than it should be possible to simply re-use them with low
> +performance overhead.
> +
> +In order to free the EM, provided earlier by the driver (e.g. when the m=
odule
> +is unloaded), there is a need to call the API::
> +
> +  void em_free_table(struct em_perf_table __rcu *table);
> +
> +It will allow the EM framework to safely remove the memory, when there i=
s
> +no other sub-system using it, e.g. EAS.
> +
> +To use the power values in other sub-systems (like thermal, powercap) th=
ere is
> +a need to call API which protects the reader and provide consistency of =
the EM
> +table data::
>
> +  struct em_perf_state *em_get_table(struct em_perf_domain *pd);
>
> -2.4 Description details of this API
> +It returns the 'struct em_perf_state' pointer which is an array of perfo=
rmance
> +states in ascending order.
> +
> +When the EM table is not needed anymore there is a need to call dedicate=
d API::
> +
> +  void em_put_table(void);
> +
> +In this way the EM safely uses the RCU read section and protects the use=
rs.
> +It also allows the EM framework to manage the memory and free it.
> +
> +There is dedicated API for device drivers to calculate em_perf_state::co=
st
> +values::
> +
> +  int em_dev_compute_costs(struct device *dev, struct em_perf_state *tab=
le,
> +                           int nr_states);
> +
> +These 'cost' values from EM are used in EAS. The new EM table should be =
passed
> +together with the number of entries and device pointer. When the computa=
tion
> +of the cost values is done properly the return value from the function i=
s 0.
> +The function takes care for right setting of inefficiency for each perfo=
rmance
> +state as well. It updates em_perf_state::flags accordingly.
> +Then such prepared new EM can be passed to the em_dev_update_perf_domain=
()
> +function, which will allow to use it.
> +
> +More details about the above APIs can be found in ``<linux/energy_model.=
h>``
> +or in Section 4.2 with an example code showing simple implementation of =
the
> +updating mechanism in a device driver.
> +
> +
> +3.5 Description details of this API
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  .. kernel-doc:: include/linux/energy_model.h
>     :internal:
> @@ -187,8 +292,11 @@ or in Section 2.4
>     :export:
>
>
> -3. Example driver
> ------------------
> +4. Examples
> +-----------
> +
> +4.1 Example driver with EM registration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>  The CPUFreq framework supports dedicated callback for registering
>  the EM for a given CPU(s) 'policy' object: cpufreq_driver::register_em()=
.
> @@ -242,3 +350,81 @@ EM framework::
>    39   static struct cpufreq_driver foo_cpufreq_driver =3D {
>    40           .register_em =3D foo_cpufreq_register_em,
>    41   };
> +
> +
> +4.2 Example driver with EM modification
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This section provides a simple example of a thermal driver modifying the=
 EM.
> +The driver implements a foo_thermal_em_update() function. The driver is =
woken
> +up periodically to check the temperature and modify the EM data::
> +
> +  -> drivers/soc/example/example_em_mod.c
> +
> +  01   static void foo_get_new_em(struct device *dev)
> +  02   {
> +  03           struct em_perf_table __rcu *runtime_table;
> +  04           struct em_perf_state *table, *new_table;
> +  05           struct em_perf_domain *pd;
> +  06           unsigned long freq;
> +  07           int i, ret;
> +  08
> +  09           pd =3D em_pd_get(dev);
> +  10           if (!pd)
> +  11                   return;
> +  12
> +  13           runtime_table =3D em_allocate_table(pd);
> +  14           if (!runtime_table)
> +  15                   return;
> +  16
> +  17           new_table =3D runtime_table->state;
> +  18
> +  19           table =3D em_get_table(pd);
> +  20           for (i =3D 0; i < pd->nr_perf_states; i++) {
> +  21                   freq =3D table[i].frequency;
> +  22                   foo_get_power_perf_values(dev, freq, &new_table[i=
]);
> +  23           }
> +  24           em_put_table();
> +  25
> +  26           /* Calculate 'cost' values for EAS */
> +  27           ret =3D em_dev_compute_costs(dev, table, pd->nr_perf_stat=
es);
> +  28           if (ret) {
> +  29                   dev_warn(dev, "EM: compute costs failed %d\n", re=
t);
> +  30                   em_free_table(runtime_table);
> +  31                   return;
> +  32           }
> +  33
> +  34           ret =3D em_dev_update_perf_domain(dev, runtime_table);
> +  35           if (ret) {
> +  36                   dev_warn(dev, "EM: update failed %d\n", ret);
> +  37                   em_free_table(runtime_table);
> +  38                   return;
> +  39           }
> +  40
> +  41           ctx->runtime_table =3D runtime_table;

Because here is ctx, maybe the foo_get_new_em(struct device *dev)
shoule be foo_get_new_em(struct foo_context *ctx)?


BR
---
xuewen

> +  42   }
> +  43
> +  44   /*
> +  45    * Function called periodically to check the temperature and
> +  46    * update the EM if needed
> +  47    */
> +  48   static void foo_thermal_em_update(struct foo_context *ctx)
> +  49   {
> +  50           struct device *dev =3D ctx->dev;
> +  51           int cpu;
> +  52
> +  53           ctx->temperature =3D foo_get_temp(dev, ctx);
> +  54           if (ctx->temperature < FOO_EM_UPDATE_TEMP_THRESHOLD)
> +  55                   return;
> +  56
> +  57           foo_get_new_em(dev);
> +  58   }
> +  59
> +  60   static void foo_exit(void)
> +  61   {
> +  62           struct foo_context *ctx =3D glob_ctx;
> +  63
> +  64           em_free_table(ctx->runtime_table);
> +  65   }
> +  66
> +  67   module_exit(foo_exit);
> --
> 2.25.1
>


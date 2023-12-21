Return-Path: <linux-kernel+bounces-7932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0602081AF68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42A7287820
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FD912E74;
	Thu, 21 Dec 2023 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0C9Onu+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D51D2FF;
	Thu, 21 Dec 2023 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2041d5a95d9so352228fac.0;
        Wed, 20 Dec 2023 23:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703143704; x=1703748504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DRLKGY+UJzcaWlDysmkmejQFVvr3OFowyPsWymx3Xc=;
        b=G0C9Onu+oOrRaNoylmFsq3uR3SCnj38DvibI2fQTZxmoaXZFvaToVe0LLcnnVSxgSB
         0zdC2cjS1+DcUY7y2c1nIAde9M6gTr6V2LUeVoILrIjytXK2WADJbP/EzIVsUX1LsrrY
         UR8cuQS9eV8OUT7HWSERrYUgqmcQu69WRJUl6Bnk8RiqV+ZoeqCQh/8ZyHF9jgjRSM0t
         5XLKgeXfuFs5JSIgOZbUgWCEc3mTD881y8932tJKzfEZY82ThBPCCZ2vRclQBr8T2Bbq
         Fu4gi4KxakWHWXpsu9y2JuKhM2O/lLVYiiHkyM1ciNCkPSQSn/44guZgpD+Xj2JlYSgM
         mbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703143704; x=1703748504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DRLKGY+UJzcaWlDysmkmejQFVvr3OFowyPsWymx3Xc=;
        b=Xw8wremoAzgTEIX+lAvoRlbuxthUfTwLT0qIsC422g+/SBZKorVkAmGNNvF/aIPvB4
         aZNbtISduedd0xSolpDaljzu0DcjZ77hCGexUCnE4ZeucPgo0k2VqIwqmJ5T1lzSwb0G
         jXtpfOvXZKSy9sHmnPmykxKH3QJgkNFn0V4Td46CbWvU1nbxjK0VmYH4s97l7KANgmFR
         OfmSOpt+6UvsM+duUga6qAubHbjoVgpZyRCbbc5iVCXoCJevNfdLQQ3DunYjJKFD7iYL
         XlZo/j2lSS4Bv39JGaNeoCWkY62Wu7YLn3UTeIIe35D8Ek085PQR8ntp/Flr+vw6oxom
         u8XA==
X-Gm-Message-State: AOJu0YwHnS31SI2QxvghJEi1UIzrhi95jHLN0l3V4OfwnRKPfJGIEROI
	0N1eKuvp0D/swNXssrCeZ4Fg2lwWAKgrmnP36TA=
X-Google-Smtp-Source: AGHT+IGb45JIZJ11fyLjeJQPMWKEZR7wN0c3PiZf9JxG8mZOsbtF9hpHLtyrAxR3lrkh0stftSK8lmnWaJmq/o7d8vI=
X-Received: by 2002:a05:6870:4787:b0:203:daf3:ecc with SMTP id
 c7-20020a056870478700b00203daf30eccmr1179862oaq.60.1703143703979; Wed, 20 Dec
 2023 23:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220110339.1065505-1-lukasz.luba@arm.com> <20231220110339.1065505-2-lukasz.luba@arm.com>
In-Reply-To: <20231220110339.1065505-2-lukasz.luba@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 21 Dec 2023 15:28:12 +0800
Message-ID: <CAB8ipk9PQbS=bjZ8F8brCfdXOgz6HUT0on2K1ZDLAaOhV9OpZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] OPP: Add API to update EM after adjustment of voltage
 for OPPs
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, 
	sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org, 
	daniel.lezcano@linaro.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	m.szyprowski@samsung.com, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 7:02=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> There are device drivers which can modify voltage values for OPPs. It
> could be due to the chip binning and those drivers have specific chip
> knowledge about this. This adjustment can happen after Energy Model is
> registered, thus EM can have stale data about power.
>
> Introduce new API function which can be used by device driver which
> adjusted the voltage for OPPs. The implementation takes care about
> calculating needed internal details in the new EM table ('cost' field).
> It plugs in the new EM table to the framework so other subsystems would
> use the correct data.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/opp/of.c       | 69 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 81fa27599d58..992434c0b711 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1596,3 +1596,72 @@ int dev_pm_opp_of_register_em(struct device *dev, =
struct cpumask *cpus)
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> +
> +/**
> + * dev_pm_opp_of_update_em() - Update Energy Model with new power values
> + * @dev                : Device for which an Energy Model has to be regi=
stered
> + *
> + * This uses the "dynamic-power-coefficient" devicetree property to calc=
ulate
> + * power values for EM. It uses the new adjusted voltage values known fo=
r OPPs
> + * which have changed after boot.
> + */
> +int dev_pm_opp_of_update_em(struct device *dev)
> +{
> +       struct em_perf_table __rcu *runtime_table;
> +       struct em_perf_state *table, *new_table;
> +       struct em_perf_domain *pd;
> +       int ret, table_size, i;
> +
> +       if (IS_ERR_OR_NULL(dev))
> +               return -EINVAL;
> +
> +       pd =3D em_pd_get(dev);
> +       if (!pd) {
> +               dev_warn(dev, "Couldn't find Energy Model %d\n", ret);
> +               return -EINVAL;
> +       }
> +
> +       runtime_table =3D em_allocate_table(pd);
> +       if (!runtime_table) {
> +               dev_warn(dev, "new EM allocation failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       new_table =3D runtime_table->state;
> +
> +       table =3D em_get_table(pd);
> +       /* Initialize data based on older EM table */
> +       table_size =3D sizeof(struct em_perf_state) * pd->nr_perf_states;
> +       memcpy(new_table, table, table_size);
> +
> +       em_put_table();
> +
> +       /* Update power values which might change due to new voltage in O=
PPs */
> +       for (i =3D 0; i < pd->nr_perf_states; i++) {
> +               unsigned long freq =3D new_table[i].frequency;
> +               unsigned long power;
> +
> +               ret =3D _get_power(dev, &power, &freq);
> +               if (ret)
> +                       goto failed;

Need we use the EM_SET_ACTIVE_POWER_CB(em_cb, _get_power) and call
em_cb->active_power?

> +
> +               new_table[i].power =3D power;
> +       }
> +
> +       ret =3D em_dev_compute_costs(dev, new_table, pd->nr_perf_states);
> +       if (ret)
> +               goto failed;
> +
> +       ret =3D em_dev_update_perf_domain(dev, runtime_table);
> +       if (ret)
> +               goto failed;
> +
> +       return 0;
> +
> +failed:
> +       dev_warn(dev, "EM update failed %d\n", ret);
> +       em_free_table(runtime_table);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_of_update_em);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index ccd97bcef269..b3ab117890fc 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -464,6 +464,7 @@ struct device_node *dev_pm_opp_get_of_node(struct dev=
_pm_opp *opp);
>  int of_get_required_opp_performance_state(struct device_node *np, int in=
dex);
>  int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_table *o=
pp_table);
>  int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus);
> +int dev_pm_opp_of_update_em(struct device *dev);
>  static inline void dev_pm_opp_of_unregister_em(struct device *dev)
>  {
>         em_dev_unregister_perf_domain(dev);
> @@ -527,6 +528,11 @@ static inline void dev_pm_opp_of_unregister_em(struc=
t device *dev)
>  {
>  }
>
> +static inline int dev_pm_opp_of_update_em(struct device *dev)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static inline int of_get_required_opp_performance_state(struct device_no=
de *np, int index)
>  {
>         return -EOPNOTSUPP;
> --
> 2.25.1
>

